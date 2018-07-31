Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]
    
    # 瀏覽所有餐廳的最新動態
    collection do
      get :feeds
      get :ranking
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
  
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :friend_list
    end
  end

  resources :followships, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]

  resources :categories, only: :show
  root "restaurants#index"

  

  namespace :admin do
    resources :restaurants
    resources :categories
    root "restaurants#index"
  end
end
