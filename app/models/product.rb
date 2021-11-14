# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  price       :decimal(8, 2)
#  quantity    :integer          default(0)
#  slug        :string
#  status      :integer          default("newly")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#  index_products_on_slug         (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
class Product < ApplicationRecord
  extend FriendlyId
  include Pagy::Backend
  friendly_id :name, use: :slugged
  has_many_attached :images
  belongs_to :category
  has_one :recommended, dependent: :destroy
  has_one :benefit, dependent: :destroy
  has_many :product_ingredients, dependent: :destroy
  has_many :ingredients, through: :product_ingredients
  has_one  :promotion, dependent: :destroy
  has_many :how_to_uses, dependent: :destroy

  enum status: [     
    :newly, :normally, :close_date, 
    :out_of_stocks, :stop_producing, :waiting_price 
  ] 

  scope :by_limit, -> (size=50) { includes(:category).order(:created_at).limit(size) }
  scope :by_order, -> { 
    includes(:promotion, :recommended)
    .left_joins(:promotion, :recommended)
    .order(:created_at) 
  }
  scope :by_product, -> (id) { 
    includes(:promotion, :recommended)
    .left_joins(:promotion, :recommended)
    .where(id: id).or(Product.where(slug: id)).first 
  }

  after_create_commit :insert_item
  after_destroy_commit :remove_item
  after_update_commit :update_item

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

  def discount?
    self.promotion && self.promotion.discount? && self.promotion.started? || false
  end

  def discount
    return self.price unless self.discount?
    self.price - (self.price*self.promotion.value)/100.0
  end

  private
  def insert_item
    if Product.count == 1
      broadcast_replace_to 'products' ,
        partial: 'products/show_items',
        locals: { products: [], user: User.current, pagy: nil, clear_screen: true },
        target: 'items'
    end
    broadcast_prepend_to 'products' ,
      partial: 'products/product',
      locals: { products: [self], user: User.current },
      target: 'items'
  end

  def remove_item
    broadcast_remove_to "products"
    if Product.count == 0
      broadcast_replace_to 'products' ,
        partial: 'products/show_items',
        locals: { products: [], user: User.current, pagy: nil },
        target: 'items'
    end
  end

  def update_item
    return if User.current.nil?
    broadcast_replace_to :show, 
      partial: 'products/item',
      locals: { item: self, user: User.current },
      target: "show-product-#{id}"

    # broadcast_replace_to :products, 
    #   partial: 'products/product',
    #   locals: { item: self, user: User.current },
    #   target: "product_#{id}"

    broadcast_replace_to 'user-cart',
      partial: 'shared/cart',
      locals: { id: "cart-#{User.current.cart.id}", quantity: User.current.cart.counter, badge: {badge: true}, ordered: false },
      target: "cart-#{User.current.cart.id}"

    quantity = User.current.cart.line_item(id)&.quantity
    broadcast_replace_to 'user-add2cart',
      partial: 'shared/cart',
      locals: { id: "user-add2cart-#{id}", quantity: quantity, badge: {badge: true}, ordered: true },
      target: "user-add2cart-#{id}"
  end
end
