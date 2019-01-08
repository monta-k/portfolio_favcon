Rails.application.routes.draw do
  root to: "pages#index"
  devise_for :users
  resources :users, only: [:edit, :update, :show]
  resources :music, only: [:index]
  resources :movie, only: [:index]
  resources :posts, only: [:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
