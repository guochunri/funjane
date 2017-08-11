class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?


  def admin_required
    if !current_user.admin?
      redirect_to "/", alert: t('warning-not-admin')
    end
  end

  # 购物车

  helper_method :current_cart

  def current_cart
    @current_cart ||= find_cart
  end

  def find_cart
    cart = Cart.find_by(id: session[:cart_id])
    if cart.blank?
      cart = Cart.create
    end
    session[:cart_id] = cart.id
    return cart
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
