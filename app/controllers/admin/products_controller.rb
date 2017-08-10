class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  layout "admin"

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new

    @brands = Brand.all.map { |b| [b.name, b.id] }
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def create
    @product = Product.new(product_params)
    @brands = Brand.all.map { |b| [b.name, b.id] }
    @product.brand_id = params[:brand_id]
    @categories = Category.all.map { |c| [c.name, c.id] }
    @product.category_id = params[:category_id]

    if @product.save
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    @brands = Brand.all.map { |b| [b.name, b.id] }
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def update
    @product = Prodcut.find(params[:id])
    @brands = Brand.all.map { |b| [b.name, b.id] }
    @product.brand_id = params[:brand_id]
    @categories = Category.all.map { |c| [c.name, c.id] }
    @product.category_id = params[:category_id]

    if @product.update(product_params)
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def publish
    @product = Product.find(params[:id])
    @product.publish!
    redirect_to :back
  end

  def hide
    @product = Product.find(params[:id])
    @product.hide!
    redirect_to :back
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity, :category_id, :brand_id, :is_hidden)
  end

end
