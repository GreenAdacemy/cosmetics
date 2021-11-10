module LineItemHelper
  def quantity(cart, product, order = nil)
    p cart
    p order
    line_item = (cart ? cart : order).line_items.by_product(product)
    line_item.nil? ? 0 : line_item.quantity
  end
end
