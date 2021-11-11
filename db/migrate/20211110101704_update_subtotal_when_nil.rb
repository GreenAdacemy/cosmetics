class UpdateSubtotalWhenNil < ActiveRecord::Migration[6.1]
  def change
    Order.where(subtotal: nil).update(subtotal: 0)
  end
end
