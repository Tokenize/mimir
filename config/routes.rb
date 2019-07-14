Rails.application.routes.draw do
  devise_for :users

  namespace :api, constraints: lambda { |req| req.format == :json }  do
    resources :events, only: :create
  end

  resources :devices do
    resources :events, shallow: true, only: :index
  end

  root to: 'home#index'
end
