Rails.application.routes.draw do
  devise_for :users
  resources :posts, only: [:index, :show, :create]

  root to: "posts#index"
end
