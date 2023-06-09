Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users
  post 'auth/login', to: 'authentication#login' , as: 'login'
  namespace :api do
    namespace :v1 do
      resources :planes, only: [:index, :create, :show, :destroy]
      resources :planes_reservations, only: [:index, :create, :destroy]
    end
  end
end
