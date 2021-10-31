class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :get_cart

  private
  def get_cart
    return unless user_signed_in?
    @cart = current_user.cart || current_user.orders.create
  end
end
