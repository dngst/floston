Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  get '/users/:id', to: 'users#show',as: :user
  # Defines the root path route ("/")
  root "home#index"
end
