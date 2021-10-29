# == Schema Information
#
# Table name: how_to_uses
#
#  id         :bigint           not null, primary key
#  content    :text
#  section    :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_how_to_uses_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
class HowToUse < ApplicationRecord
  belongs_to :product
  enum section: [:use, :point]
end
