module CartItemsHelper

  def render_product_price_count(product,quantity)
    count = "$ " + (product.price * quantity).to_s
  end

end
