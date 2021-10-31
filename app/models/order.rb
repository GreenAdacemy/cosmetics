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
  enum status: [:in_cart, :to_confirm, :confirmed, :to_ship, :shipping, :shipped, :completed, :cancel, :refunded]

  def in_cart?(product)
    line_items.include?(product)
  end
end
