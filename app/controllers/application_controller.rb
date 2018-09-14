class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_order
  helper_method :destroy_order
  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end

  def destroy_order
  	session[:order_id] = nil
  end
end
