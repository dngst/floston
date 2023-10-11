Rails.application.routes.draw do
  resources :articles
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users do
    resources :requests
  end
  # Defines the root path route ("/")
  root "home#index"
end
