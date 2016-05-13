Rails.application.routes.draw do
  root "posts#index"

  resources :posts do
    resources :comments
    member do
      post "like"
    end
  end


  devise_for :users
end
