Rails.application.routes.draw do
  namespace :admin do
    root 'application#index'
    resources :users
  end

  root "posts#index"

  resources :posts do
    resources :comments
    member do
      post "like"
    end
  end

  devise_for :users
end
