class ProductsController < ApplicationController

  def index
    # 商品类型 / 品牌
    @category_groups = CategoryGroup.published
    @brands = Brand.published

    # 判断是否筛选分类
    if params[:category].present?
      @category = params[:category]
      @category_id = Category.find_by(name: @category)

      @products = Product.where(:category => @category_id).published.paginate(:page => params[:page], :per_page => 12)

    # 判断是否筛选品牌
    elsif params[:brand].present?
      @brand = params[:brand]
      @brand_id = Brand.find_by(name: @brand)

      @products = Product.where(:brand => @brand_id).published.paginate(:page => params[:page], :per_page => 12)

    # 预设显示所有公开商品
    else
      @products = Product.published.paginate(:page => params[:page], :per_page => 12)
    end

  end

  def show
    @product = Product.find(params[:id])
    @product_images = @product.product_images.all

    @category_groups = CategoryGroup.published
    @brands = Brand.published
  end

  # 加入购物车
  def add_to_cart
    @product = Product.find(params[:id])

    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] = t('message-add-to-cart-success')
    else
      flash[:warning] = t('message-already-added')
    end

    redirect_to :back
  end

end
