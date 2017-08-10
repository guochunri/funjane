class CartsController < ApplicationController

  def index
    @carts = Cart.all
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
