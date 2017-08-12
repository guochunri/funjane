class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:add_to_wish_list, :remove_from_wish_list]
  before_action :validate_search_key, only: [:search]

  def index
    # 商品类型 / 品牌
    @category_groups = CategoryGroup.published
    @brands = Brand.published

    # 判断是否筛选分类
    if params[:category].present?
      @category_s = params[:category]
      @category = Category.find_by(name: @category_s)

      @products = Product.where(:category => @category.id).published.recent.paginate(:page => params[:page], :per_page => 12)

    # 判断是否筛选类型
    elsif params[:group].present?
      @group_s = params[:group]
      @group = CategoryGroup.find_by(name: @group_s)

      @products = Product.joins(:category).where("categories.category_group_id" => @group.id).published.recent.paginate(:page => params[:page], :per_page => 12)

      # 判斷是否篩選品牌
      elsif params[:brand].present?


    # 判断是否筛选品牌
    elsif params[:brand].present?
      @brand_s = params[:brand]
      @brand = Brand.find_by(name: @brand_s)

      @products = Product.where(:brand => @brand.id).published.recent.paginate(:page => params[:page], :per_page => 12)

    # 预设显示所有公开商品
    else
      @products = Product.published.recent.paginate(:page => params[:page], :per_page => 12)
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

  # 将该商品加入愿望清单
  def add_to_wish_list
    @product = Product.find(params[:id])
    if !current_user.is_wish_list_owner_of?(@product)
      current_user.add_to_wish_list!(@product)
    end

    redirect_to :back
  end

  # 从愿望清单上刪除该商品
  def remove_from_wish_list
    @product = Product.find(params[:id])
    if current_user.is_wish_list_owner_of?(@product)
      current_user.remove_from_wish_list!(@product)
    end

    redirect_to :back
  end

  def search
    if @query_string.present?
      # 显示符合关键字的商品 #
      search_result = Product.joins(:brand).ransack(@search_criteria).result(:distinct => true)
      @products = search_result.published.recent.paginate(:page => params[:page], :per_page => 12 )
    end

    @category_groups = CategoryGroup.published
    @brands = Brand.published
  end

  protected

  def validate_search_key
    # 去除特殊字符 #
    @query_string = params[:keyword].gsub(/\\|\'|\/|\?/, "") if params[:keyword].present?
    @search_criteria = search_criteria(@query_string)

  end

  def search_criteria(query_string)
    # 筛选多个栏位 #
    { :name_or_description_or_brand_name_cont => query_string }
  end

end
