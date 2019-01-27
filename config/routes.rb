Rails.application.routes.draw do
  root to: "pages#index"
  get "notifications/:id/link_through", to: "notifications#link_through", as: :link_through
  devise_for :users
  resources :users, only: [:edit, :update, :show] do
    member do
      get :following, :followers
    end
    resources :likes, only: [:index], shallow: true
  end
  resources :music, only: [:index]
  resources :movie, only: [:index]
  resources :posts, only: [:new, :create, :destroy] do
    resources :likes, only: [:create, :destroy], shallow: true
    resources :comments, only: [:index, :create, :destroy], shallow: true
  end
  resources :relationships, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
