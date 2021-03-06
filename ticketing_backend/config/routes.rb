Rails.application.routes.draw do
  apipie
  resources :sessions, only: [:create, :destroy]

  namespace :api do
    namespace :v1 do
      get "users/me", to: "users#me"
      resources :users
      resources :tickets
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
