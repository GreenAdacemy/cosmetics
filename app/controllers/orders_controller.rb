class OrdersController < ApplicationController
  def index
  end

  def create
    order_params = JSON.parse(params[:order])
    product = Product.by_product(order_params[:id])
    if @cart.in_cart?(product.id)
    else
    end
    p product
    p product.name
    p current_user
    p @cart
  end

  def cart    
  end
end
