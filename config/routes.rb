Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  #--=== 前台 ===-->
  resources :products

  #--=== 后台 ===-->
  namespace :admin do
    # 品牌 #
    resources :brands do
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
