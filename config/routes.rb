Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  #--=== 前台 ===-->
  resources :products do
    member do
      post :add_to_cart
      post :add_to_wish_list
      post :remove_from_wish_list
    end
  end

  # 购物车
  resources :carts do
    collection do
      delete :clear   # 清空购物车
      post :checkout  # 下订单
    end
  end

  resources :cart_items

  # 订单
  resources :orders do
    member do
      post :pay # 付款（暂）
      post :apply_to_cancel # 申请取消订单
    end
  end

  #--=== 使用者专区 ===-->
  namespace :account do
    # 历史订单
    resources :orders
    # 收藏清单
    resources :products do
      member do
        post :add_to_cart
        post :remove_from_wish_list
      end
    end
  end

  #--=== 管理员专区 ===-->
  namespace :admin do

    # 订单管理
    resources :orders do
      member do
        post :cancel
        post :ship
        post :shipped
        post :return
      end
    end

    # 品牌 #
    resources :brands do
      member do
        post :publish
        post :hide
      end
    end

    # 类型 #
    resources :category_groups do
      member do
        post :publish
        post :hide
      end
    end

    # 分类 #
    resources :categories do
      member do
        post :publish
        post :hide
      end
    end

    # 商品 #
    resources :products do
      member do
        post :publish
        post :hide
      end
    end
  end

end
