class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  layout "admin"

  def index
    @products = Product.all.recent.paginate(:page => params[:page], :per_page => 15)
  end

  def show
    @product = Product.find(params[:id])

    # 商品图片
    @product_images = @product.product_images.all
  end

  def new
    @product = Product.new

    # 商品图片
    @product_image = @product.product_images.build

    # 商品所属的品牌/分类
    @brands = Brand.all
    @categories = Category.all.order("category_group_id, name")
    # @brands = Brand.all.map { |b| [b.name, b.id] }
    # @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def create
    @product = Product.new(product_params)

    # 商品所属的品牌
    # @brands = Brand.all.map { |b| [b.name, b.id] }
    # @product.brand_id = params[:brand_id]
    # 商品所属的分类
    # @categories = Category.all.map { |c| [c.name, c.id] }
    # @product.category_id = params[:category_id]

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

    # 商品所属的品牌/分类
    @brands = Brand.all
    @categories = Category.all.order("category_group_id, name")
    # @brands = Brand.all.map { |b| [b.name, b.id] }
    # @categories = Category.all.map { |c| [c.name, c.id] }
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
      redirect_to admin_products_path and return
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

  # 精选商品
  def chosen
    @product = Product.find(params[:id])
    if @product.is_chosen == true
      @product.no_chosen!
    else
      @product.chosen!
    end

    redirect_to :back
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity, :category_id, :brand_id, :is_hidden, :is_chosen)
  end

end
