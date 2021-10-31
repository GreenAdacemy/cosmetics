# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  counter    :integer          default(0)
#  status     :integer          default(0)
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
end
