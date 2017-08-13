module CartsHelper

  # 计算购物车商品总价
  def render_cart_total_price(cart)
    cart.total_price
  end

  # 计算剩余库存
  def render_product_quantity(product)
    @product = Product.find(product)
    @orderSum = OrderItem.where("product_id" => product).sum(:quantity)
    @product.quantity - @orderSum
  end

end
