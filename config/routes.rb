Rails.application.routes.draw do
  namespace :admin do
    root 'application#index'
    resources :users
  end

  scope '(:locale)' do
    root "posts#index"

    resources :posts do
      resources :comments do
        member do
          post "like"
        end
      end
      member do
        post "like"
      end
    end
    devise_for :users
  end
end
