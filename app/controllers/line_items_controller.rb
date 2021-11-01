class LineItemsController < ApplicationController
  def update
    product = Product.by_product(params[:id])
    @cart.in_cart?(product.id) ? increment_quantity(product, quantity) : new_line(product)
    # render json: {
    #   badge: User.current.cart.counter
    # }
    respond_to do |f|
      f.turbo_stream
    end        
  end

  private
  def quantity
    order = JSON.parse(params[:order], symbolize_names: true)
    order[:type].downcase.to_sym == :minus ? -1 : 1
  end

  def increment_quantity(product, n)
    line_item = @cart.line_item(product)
    line_item.update(quantity: line_item.quantity + n < 0 ? 0 : line_item.quantity + n)
  end

  def new_line(product)
    @cart.line_items.create(
      product_id: product.id,
      discount: product.discount? ? product.promotion.value : 0,
      price: product.price,
      quantity: 1
    )
  end
end
