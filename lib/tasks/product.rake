require 'csv'
require 'open-uri'

namespace :product do
  desc 'Init default product for project'
  task init: :environment do
    # Product.destroy_all
    CSV.foreach(
      Rails.root.join('db/csv/products.csv'), 
      headers: true
    ) do |row|
      @category = Category.find_or_create_by(name: row['category'].downcase) if row['category'].present?
      @product = create_product(row, @category) if new_record?(row)
      add_image(@product, row['images']) if row['images'].present?
    end
  end

  private
  def new_record?(row)
    row['name'].present?
  end

  def create_product(row, category)
    puts "Create product #{row['name']}"
    Product.create(
      name: row['name'].downcase,
      description: row['description'].downcase,
      price: row['price'].to_f/1000.0,
      category_id: category.id
    )
  end

  def add_image(product, url)
    puts "- Add image for product [#{product.name}]"
    url.strip!
    product.images.attach(
      io:URI.parse(url).open,
      filename: File.basename(url)
    )
  end

end
