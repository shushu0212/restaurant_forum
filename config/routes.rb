Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]
    
    # 瀏覽所有餐廳的最新動態
    collection do
      get :feeds
    end

    
    member do
      # 瀏覽個別餐廳的 Dashboard
      get :dashboard
      
      # 收藏 / 取消收藏
      post :favorite
      post :unfavorite

      # 喜歡 / 不喜歡
      post :like
      post :unlike

    end
  end
  
  resources :categories, only: :show
  root "restaurants#index"

  # 將 :index 加入開放項目
  resources :users, only: [:index, :show, :edit, :update]
  # 追蹤 / 取消追蹤
  resources :followships, only: [:create, :destroy]

  namespace :admin do
    resources :restaurants
    resources :categories
    root "restaurants#index"
  end
end
