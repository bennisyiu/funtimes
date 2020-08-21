Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/login', to: 'login#login'
      post '/login', to: 'login#login'
      put '/update_user/:id', to: 'login#update_user_info'
      get '/users/:id', to: 'login#user_info'
      get '/randomizer', to: 'evints#randomizer'
      resources :evints, only: [:index, :show]
      resources :itineraries, only: [:index, :show, :create, :destroy]
      resources :activities, only: [:destroy]
      resources :guests, only: [:destroy]
    end
  end
end
