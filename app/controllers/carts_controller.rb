class CartsController < ApplicationController

  def index
    @carts = Cart.all

    # 商品类型 / 品牌
     @category_groups = CategoryGroup.published
     @brands = Brand.published
  end

  # 清空购物车
  def clear
    current_cart.clear!
    flash[:warning] = t('message-clear-cart-success')
    redirect_to carts_path
  end

  # 下订单
  def checkout
    @order = Order.new
  end

end
