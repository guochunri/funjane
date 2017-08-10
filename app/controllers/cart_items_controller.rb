class CartItemsController < ApplicationController

  # 删除购物车内单一商品
  def destroy
    @cart = current_cart
    @cart_item = @cart.cart_items.find_by(product_id: params[:id])
    @product = @cart_item.product
    @cart_item.destroy

    redirect_to :back
  end
  
end
