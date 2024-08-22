class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_cart

  private

  def current_cart
    if session[:cart_id]
      @current_cart = Cart.find_by(id: session[:cart_id])
      if @current_cart.nil?
        session[:cart_id] = nil
        @current_cart = Cart.create
        session[:cart_id] = @current_cart.id
      end
    else
      @current_cart = Cart.create
      session[:cart_id] = @current_cart.id
    end
  end
end
