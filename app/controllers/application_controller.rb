class ApplicationController < ActionController::Base

  helper_method :current_waiter
  helper_method :current_chef
  helper_method :waiter_logged_in?
  helper_method :chef_logged_in?

  def current_waiter
    Waiter.find_by(id: session[:waiter_id])
  end

  def current_chef
    Chef.find_by(id: session[:chef_id])
  end

  def waiter_logged_in?
    !current_waiter.nil?
  end

  def chef_logged_in?
    !current_chef.nil?
  end

  def chef_authorized
    unless chef_logged_in?
      session.clear
      redirect_to chef_login_path
    end
  end

  def waiter_authorized
    unless waiter_logged_in?
      session.clear
      redirect_to root_path
    end
  end

  def authorized
    unless waiter_logged_in? || chef_logged_in?
      session.clear
      redirect_to root_path
    end
  end

  def is_waiter
    if waiter_logged_in?
      redirect_to waiters_path
    end
  end

  def is_chef
    if chef_logged_in?
      redirect_to order_items_path
    end
  end

end
