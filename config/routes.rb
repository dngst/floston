Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  resources :users do
    resources :requests do
      resources :comments, except: [ :show ]
      member do
          patch "close_request"
          patch "reopen_request"
        end
    end
  end
  resources :properties
  get "search", to: "search#index"
  # public
  root "home#index" # ("/")
  get "/service-worker.js" => "service_worker#service_worker"
  get "/manifest.json" => "service_worker#manifest"
end
