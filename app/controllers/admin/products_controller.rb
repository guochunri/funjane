class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  layout "admin"

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @product_images = @product.product_images.all
  end

  def new
    @product = Product.new
    @product_image = @product.product_images.build

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
      if params[:product_images] != nil
        params[:product_images]['image'].each do |i|
          @product_image = @product.product_images.create(:image => i)
        end
      end
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
    @product = Product.find(params[:id])

    if params[:product_images] != nil
      @product.product_images.destroy_all

      params[:product_images]['image'].each do |i|
        @product_image = @product.product_images.create(:image => i)
      end
      @product.update(product_params)
    elsif @product.update(product_params)
      redirect_to admin_products_path
    else
      render :edit
    end

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
