# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  price       :decimal(8, 2)
#  quantity    :integer          default(0)
#  status      :integer          default("newly")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
class Product < ApplicationRecord
  has_many_attached :images
  belongs_to :category

  enum status: [     
    :newly, :normally, :close_date, 
    :out_of_stocks, :stop_producing, :waiting_price 
  ] 

  scope :by_limit, -> (size=50) { includes(:category).order(:created_at).limit(size) }

  after_create_commit { broadcast_prepend_to "products" }
  after_destroy_commit { broadcast_remove_to "products" }
  after_update_commit { broadcast_replace_to "products" }

  def attach_url(index = 0)
    return nil unless self.images.attached?
    len = self.images.length - 1
    image = self.images[index > len ? len :  index]
    return nil unless image.present?
    is_storage_from_disk? ? storage_local_path(image.key) : storage_public_path(image.key)
  end

  def thumbnail
    return nil unless self.images.attached?
    image = self.images.first
    image.variable? ? image.variant(resize: '200x200') : image
  end

  def category_name
    self.category.name.gsub(/\-/, ' ')
  end
end
