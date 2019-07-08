Rails.application.routes.draw do
  devise_for :users

  resources :devices

  root to: 'home#index'
end
