Rails.application.routes.draw do
  get 'search', to: 'search#index'
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
