Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations, :password], controllers: {
    sessions: 'admins/sessions'
  }
  namespace :admins do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
    resources :comments, only: [:index, :destroy]
  end
  
  
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  post 'homes/guest_sign_in' => 'homes#guest_sign_in' ,as: "guest_sign_in"
  get 'homes/about' => 'homes#about' ,as: "about"
  get 'users/setting/:id' => 'users#setting' ,as: "setting"
  get 'users/setting/:id/favorites' => 'favorites#show' ,as: "users_favorites"
  get 'users/setting/:id/favorites/empty' => 'favorites#empty' ,as: "favorites_empty" 
  get 'users/setting/:id/posts' => 'users#users_posts' ,as: "users_setting_posts"
  get 'users/setting/:id/comments' => 'users#users_comments' ,as: "users_setting_comments"
  get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
  patch 'users/:id/withdrawal' => 'users#withdrawal' ,as: "withdrawal"
  resources :users, expect: [:new] 
  
  
  resources :posts do
      member do 
          post 'edit'
      end 
      resource :favorites, only: [:create, :destroy, :show]
      resources :comments
      resources :tags, only: [:show]
  end
  
  
  
end
