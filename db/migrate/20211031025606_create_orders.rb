class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :counter, default: 0
      t.integer :status, default: 0
      t.decimal :subtotal, precision: 8, scale: 2
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
