module ClassHelper
  def in_cart(product)
    class_names({
      'order-product--price': true,
      'fs-4': true,
      'hl-36': true,
      'me-3': true,
      discount: product.discount?
    })
  end
end