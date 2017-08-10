class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  # 产生订单
  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.total = current_cart.total_price

    if @order.save

      # 将购物车內容存入订单
      current_cart.cart_items.each do |cart_item|
        order_item = OrderItem.new
        order_item.order = @order
        order_item.product_name = cart_item.product.name
        order_item.product_price = cart_item.product.price
        order_item.quantity = cart_item.quantity
        order_item.save
      end

      # 订单成立后清空购物车
      current_cart.clear!

      redirect_to order_path(@order.token)
    else
      render 'carts/checkout'
    end
  end

  # 订单明细
  def show
    @order = Order.find_by_token(params[:id])
    @order_items = @order.order_items
  end

  # 付款（暫）
  def pay
    @order = Order.find_by_token(params[:id])
    @order.set_payment_with!(t('order-payment-method'))
    @order.make_payment! # AASM 机制

    redirect_to order_path(@order.token)

    flash[:notice] = t('message-payment-success')
  end

  # 申请取消订单
  def apply_to_cancel
    @order = Order.find(params[:id])
    flash[:notice] = t('message-cancel-request-sent')
    redirect_to :back
  end

  private

  def order_params
    params.require(:order).permit(:billing_name, :billing_address, :shipping_name, :shipping_address, :shipping_phone)
  end


end
