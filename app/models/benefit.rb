# == Schema Information
#
# Table name: benefits
#
#  id         :bigint           not null, primary key
#  value      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_benefits_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
class Benefit < ApplicationRecord
  belongs_to :product
end
