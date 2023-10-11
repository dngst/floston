Rails.application.routes.draw do
  resources :articles
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users do
    resources :requests do
      resources :comments, only: [:create]
    end
  end
  # Defines the root path route ("/")
  root "home#index"
end
