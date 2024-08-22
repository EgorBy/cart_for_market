class LineItemsController < ApplicationController

  def create
    product = Product.find_by(id: params[:product_id])
    if product
      @line_item = @current_cart.add_product(product.id)

      respond_to do |format|
        if @line_item.save
          @cart_counter = @current_cart.line_items.sum(&:quantity)
          format.turbo_stream
        else
          format.turbo_stream do
            flash.now[:error] = "Ошибка добавления item."
          end
        end
      end
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    if @current_cart.line_items.count != 0
      respond_to do |format|
        format.turbo_stream
      end
    else
      redirect_to cart_path(@current_cart)
    end

  end

  def update
    @line_item = LineItem.find(params[:id])
    quantity = params[:line_item][:quantity].to_i

    if quantity.present?
      @line_item.update(quantity: quantity)

      respond_to do |format|
        if @line_item.save
          @cart_counter = @current_cart.line_items.sum(&:quantity)
          format.turbo_stream
        else
          format.turbo_stream do
            flash.now[:error] = "Ошибка добавления item."
          end
        end
      end
    end
  end

  def open_current_cart
    redirect_to cart_path(@current_cart)
  end
end
