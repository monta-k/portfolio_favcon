Rails.application.routes.draw do
  root to: "pages#index"
  devise_for :users
  resources :users, only: [:edit, :update, :show] do
    member do
      get :following, :followers
    end
  end
  resources :music, only: [:index]
  resources :movie, only: [:index]
  resources :posts, only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
