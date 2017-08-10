class ProductsController < ApplicationController

  def index
    @products = Product.where(:is_hidden => false)
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    @product = Product.find(params[:id])
    current_cart.add_product_to_cart(@product)
    flash[:notice] = t('message-add-to-cart-success')
    redirect_to :back
  end

end
