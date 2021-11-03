class OrdersController < ApplicationController
  add_breadcrumb I18n.t('breadcrumb.home'), :root_path
  add_breadcrumb I18n.t('breadcrumb.orders'), :orders_path

  def index
  end

  def create
  end

  def cart
    add_breadcrumb I18n.t('breadcrumb.cart')
    @items = @cart.line_items
  end
end
