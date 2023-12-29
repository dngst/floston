Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users do
    resources :requests do
      resources :comments, except: [:show]
      member do
          patch 'close_request'
          patch 'reopen_request'
        end
    end
    resources :reminders, only: [:index]
    resources :stats, only: [:index]
  end
  resources :properties
  get 'search', to: 'search#index'
  resources :articles
  # payments
  get '/subscribe', to: 'subscriptions#handle_payments'
  get '/paystack_callback', to: 'subscriptions#paystack_callback'
  get '/subscribe/manage', to: 'subscriptions#manage_subscription', as: 'manage_subscription'
  # public
  get 'features', to: 'features#index'
  get 'onboarding/process', to: 'features#onboarding'
  root "home#index" # ("/")
end
