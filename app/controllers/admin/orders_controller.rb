class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  layout "admin"

  def index
    @orders = Order.order('id DESC')
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

end
