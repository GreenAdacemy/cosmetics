# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  counter    :integer          default(0)
#  status     :integer          default("in_cart")
#  subtotal   :decimal(8, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy

  enum status: [:in_cart, :checkout, :confirmed, :to_ship, :shipping, :shipped, :completed, :cancel, :refunded, :closed]

  scope :by_order, -> (order) {
    includes(:line_items).joins(:line_items).where(id: order).first
  }
  
  def in_cart?(product)
    line_items.find_by(product_id: product).present?
  end

  def line_item(product)
    line_items.find_by(product_id: product)
  end

  def update_order
    update(
      counter: self.line_items.count, 
      subtotal: self.line_items.sum('(price - (price*discount)/100.0) * quantity')
    )
  end
end
