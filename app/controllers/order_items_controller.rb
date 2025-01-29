class OrderItemsController < ApplicationController
  before_action :chef_authorized, only: [:index, :processing_item, :finish]

  def index
    @orders = OrderItemService.get_orders
  end

  def processing_item
    @order = OrderService.get_order_by_id(params[:order])
    @order = OrderService.update_status_process
  end

  def finish
    @order = OrderService.get_order_by_id(params[:order])
    @order = OrderService.update_status_finish

    respond_to do |format|
      format.html { redirect_to order_items_url }
      format.json { head :no_content }
      format.js { render :layout => false }
    end
  end
end
