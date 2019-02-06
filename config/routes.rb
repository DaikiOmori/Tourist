Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users
  get 'delete/:id/user', to: 'users#destroy_user', as: 'delete_user'
  get 'users/:id/profile', to: 'users#profile_edit', as: 'profile_edit'
  resources :blogs
  resources :likes, only: [:create, :destroy]
  resources :users, only: [:show, :new, :create, :edit, :update, :destroy ] do
    member do
      get :likes
    end
  end
  get 'rankings/like', to: 'rankings#like'
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :followings
      get :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
end

