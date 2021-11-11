class SetDefaultForSubtotalInOrders < ActiveRecord::Migration[6.1]
  def change
    change_column_default :orders, :subtotal, 0
  end
end
