class ApplicationController < ActionController::Base
  before_action :get_cart, :set_current_user
  before_action :authenticate_user!
  include Pagy::Backend

  private
  def set_current_user
    User.current = current_user 
  end  

  def get_cart
    return unless user_signed_in?
    @cart = current_user.cart || current_user.orders.create
  end
end
