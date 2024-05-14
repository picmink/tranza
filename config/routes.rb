Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get 'homes/about' => 'homes#about' ,as: "about"
  get 'users/withdrawal' => 'users#withdrawal' ,as: "withdrawal"
  get 'users/setting' => 'users#setting' ,as: "setting"
  
  resources :users, expect: [:new] do
    resource :favorites, only: [:create, :destroy]
  end 
  
  resources :posts do
      member do 
          post 'edit'
      end 
  end
   resources :tags
end
