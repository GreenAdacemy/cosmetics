# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  desc       :text
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord
  has_many :products, dependent: :destroy
end
