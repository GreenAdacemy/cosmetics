# == Schema Information
#
# Table name: line_items
#
#  id         :bigint           not null, primary key
#  discount   :integer          default(0)
#  price      :decimal(8, 2)
#  quantity   :integer          default(1)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint           not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_line_items_on_order_id    (order_id)
#  index_line_items_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (product_id => products.id)
#
class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :product, touch: true

  after_commit :update_order

  def self.by_product(id)
    find_by(product_id: id)
  end

  def total
    (price - price*discount/100.0)*quantity
  end

  private
  def update_order
    self.order.update_order
  end
end
