class OrdersController < ApplicationController
  add_breadcrumb I18n.t('breadcrumb.home'), :root_path
  add_breadcrumb I18n.t('breadcrumb.orders'), :orders_path

  def index
    @order = current_user.orders
  end

  def create
  end

  def cart
    add_breadcrumb I18n.t('breadcrumb.cart')
    @items = @cart.line_items
  end

  def show
    @order = current_user.orders.find_by(id: params[:id])
    @items = @order.line_items
  end

  def checkout
    @cart.checkout!
    redirect_to cart_path
  end
end
