Rails.application.routes.draw do
  devise_for :users

  resources :devices do
    resources :events, shallow: true, only: :index
  end

  root to: 'home#index'
end
