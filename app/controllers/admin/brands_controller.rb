class Admin::BrandsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  layout "admin"

  def index
    @brands = Brand.all
  end

  def show
    @brand = Brand.find(params[:id])
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)

    if @brand.save
      redirect_to admin_brands_path
    else
      render :new
    end
  end

  def edit
    @brand = Brand.find(params[:id])
  end

  def update
    @brand = Brand.find(params[:id])

    if @brand.update(brand_params)
      redirect_to admin_brands_path
    else
      render :edit
    end
  end

  def publish
    @brand = Brand.find(params[:id])
    @brand.publish!
    redirect_to :back
  end
 
  def hide
    @brand = Brand.find(params[:id])
    @brand.hide!
    redirect_to :back
  end

  private

  def brand_params
    params.require(:brand).permit(:name, :description, :logo, :is_hidden)
  end

end
