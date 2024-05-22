Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  post 'homes/guest_sign_in' => 'homes#guest_sign_in' ,as: "guest_sign_in"
  get 'homes/about' => 'homes#about' ,as: "about"
  get 'users/withdrawal' => 'users#withdrawal' ,as: "withdrawal"
  get 'users/setting' => 'users#setting' ,as: "setting"
  
  resources :users, expect: [:new] 
  
  resources :posts do
      member do 
          post 'edit'
      end 
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:new, :index, :create, :update, :destroy]
  end
   resources :tags
end
