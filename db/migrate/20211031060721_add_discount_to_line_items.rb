class AddDiscountToLineItems < ActiveRecord::Migration[6.1]
  def change
    add_column :line_items, :discount, :integer, default: 0
  end
end
