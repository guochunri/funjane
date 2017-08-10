module CartsHelper

  # 计算购物车商品总价
  def render_cart_total_price(cart)
    cart.total_price
  end

end
