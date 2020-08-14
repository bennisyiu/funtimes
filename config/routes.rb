Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post '/login', to: 'login#login'
      put '/update_user/:id', to: 'login#update_user_info'
      resources :evints, only: [:index, :show]
      resources :itineraries, only: [:index, :show, :create, :update, :destroy]
      resources :activities, only: [:destroy]
      resources :guests, only: [:create, :destroy]
      ## resources :guests
    end
  end
end
