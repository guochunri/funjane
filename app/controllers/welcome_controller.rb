class WelcomeController < ApplicationController
  layout "welcome"

  def index
    @intros = Intro.published

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
      @products = Product.published.chosened.paginate(:page => params[:page], :per_page => 12)
    end
  end

end
