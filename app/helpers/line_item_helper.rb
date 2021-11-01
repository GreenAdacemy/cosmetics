module LineItemHelper
  def quantity(cart, product)
    line_item = cart.line_items.by_product(product)
    line_item.nil? ? 0 : line_item.quantity
  end
end
