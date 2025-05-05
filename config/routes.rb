Rails.application.routes.draw do
  namespace :admin do
    get "products/index"
    get "products/new"
    get "products/create"
    get "products/edit"
    get "products/update"
    get "products/destroy"
    get "dashboard/index"
  end
  get "orders/index"
  get "orders/show"
  get "orders/new"
  get "orders/create"
  get "cart_items/create"
  get "cart_items/update"
  get "cart_items/destroy"
  get "carts/show"
  get "carts/update"
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  get "users/new"
  get "users/create"
  get "products/index"
  get "products/show"
  get "home/index"
  get "home/about"
  get "home/terms"
  get "home/privacy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
