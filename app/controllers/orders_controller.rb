class OrdersController < ApplicationController
  def index
  end

  def create
    order_params = JSON.parse(params[:order])
  end
end
