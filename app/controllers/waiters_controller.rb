class WaitersController < ApplicationController
  before_action :waiter_authorized, only: [:index, :update, :show, :edit, :waiter_update_password, :select_item, :cancel_item, :confirm_order, :get_orders, :show_order, :pick_order]

  def index
    @coffee = ItemService.get_item_by_category("Coffee")
    @icecream = ItemService.get_item_by_category("Ice Cream")
    @tea = ItemService.get_item_by_category("Tea")
    @cake = ItemService.get_item_by_category("Cake")
    @order_notice = ""
    @orders = Array.new
    if session[:orders]
      @orders = session[:orders]
      @total_price = session[:total_price]
    end
  end

  def new
    @waiter = Waiter.new
  end

  def create
    @waiter = Waiter.new(waiter_params)
    @is_waiter_create = WaiterService.create_waiter(@waiter)

    # check new waiter is create or not
    if @is_waiter_create
      redirect_to root_path
    else
      render :new
    end
  end

  #update waiter profile
  def update
    @waiter = WaiterService.get_waiter_by_id(params[:id])
    @is_waiter_update = WaiterService.update_waiter(@waiter, waiter_params)
    if @is_waiter_update
      redirect_to waiter_path(id: session[:waiter_id])
    else
      render :edit
    end
  end

  #show waiter profile
  def show
    @waiter = WaiterService.get_waiter_by_id(params[:id])
  end

  #edit waiter profile
  def edit
    @waiter = WaiterService.get_waiter_by_id(params[:id])
  end

  #change waiter password
  def waiter_update_password
    if params[:current_password].blank? || params[:password].blank? || params[:confirmation_password].blank?
      if params[:current_password].blank?
        @current = Messages::CURRENT_PASSWORD_REQUIRED
      end
      if params[:password].blank?
        @new = Messages::NEW_PASSWORD_REQUIRED
      end
      if params[:confirmation_password].blank?
        @confirm = Messages::CONFIRM_PASSWORD_REQUIRED
      end
      render :waiter_change_password
    else
      @waiter = WaiterService.get_waiter_by_id(session[:waiter_id])
      if @waiter.authenticate(params[:current_password])
        if params[:password] != params[:confirmation_password]
          @confirm = Messages::CONFIRM_PASSWORD_VALIDATION
          render :waiter_change_password
        else
          @is_update_password = WaiterService.update_password(@waiter, params[:password])
          if @is_update_password
            redirect_to @waiter, alert: Messages::PASSWORD_CHANGE_SUCCESS
          end
        end
      else
        @current = Messages::CURRENT_PASSWORD_VALIDATION
        render :waiter_change_password
      end
    end
  end

  def select_item
    # Initialize the orders array if doesn't exist
    session[:orders] = Array.new unless session[:orders]
    # Initialize total_price if doesn't exist
    session[:total_price] = 0 unless session[:total_price]
    same = false
    item_name = params[:name]
    item_quantity = params[:quantity].to_i
    item_price = item_quantity.to_i * params[:price].to_i
    session[:total_price] += item_price
    if session[:orders]
      session[:orders].each do |order|
        # check the value equal to selected item_name for duplicate item
        if order.value?(item_name)
          same = true
          order.merge!({ "item_name" => item_name, "quantity" => order.values[1] + item_quantity, "price" => order.values[2] + item_price })
        end
      end
    end

    unless same == true
      order = Hash[item_name: item_name, quantity: item_quantity, price: item_price]
      session[:orders].push(order)
    end

    @order_notice = ""
    respond_to do |format|
      format.js
    end
  end

  def cancel_item
    item_name = params[:item_name]
    cancel_item = nil
    for i in 0..session[:orders].length - 1
      session[:orders][i].each do |key, value|
        if (key == "item_name" && value == item_name)
          # make item list to remove from session[:orders]
          cancel_item = i
        end
      end
    end

    @order_notice = ""
    session[:total_price] -= session[:orders][cancel_item].values[2]
    session[:orders].delete_at(cancel_item)
    respond_to do |format|
      format.js
    end
  end

  def confirm_order
    orders = order_params
    waiter = WaiterService.get_waiter_by_id(session[:waiter_id])
    # create waiter's order
    waiter_order = WaiterService.create_order(waiter, "pending", orders[:total_price])
    # create items with that order
    orders[:orders].each do |order|
      WaiterService.create_order_items(waiter_order, order)
    end
    # delete the orders and total_price affter confirm one orders list
    session.delete(:orders)
    session.delete(:total_price)
    # shwo notice about confirm order
    @order_notice = Messages::ORDER_NOTICE
    respond_to do |format|
      format.js
    end
  end

  def get_orders
    @orders = WaiterService.get_waiter_orders(session[:waiter_id])
  end

  def show_order
    @order = OrderService.get_order_by_id(params[:oid])
  end

  def pick_order
    @orders = WaiterService.get_waiter_orders(session[:waiter_id])
    OrderService.update_status(params[:id], "pickup")
    respond_to do |format|
      format.js
    end
  end

  private

  def waiter_params
    params.require(:waiter).permit(:name, :email, :password, :phone, :birthday, :address)
  end

  def order_params
    params.permit(:total_price, :_method, :authenticity_token, :orders => [:item_name, :quantity, :price])
  end
end
