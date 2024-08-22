class CartsController < ApplicationController
  def show
    @cart = @current_cart
  end

  def destroy
    @cart = @current_cart
    @cart.destroy
    session[:cart_id] = nil
    redirect_to root_path
  end

  def update_discount
    @cart = @current_cart
    @cart.update(discount: params['discount'])
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("discount-wrapper", partial: "carts/templates/cart_discount_container", locals: { cart: @cart })
      end
    end
  end
end