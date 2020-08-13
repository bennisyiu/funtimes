Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
post '/login', to: 'login#login'

   namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :evints, only: [:index, :show]
      resources :itineraries, only: [:index, :show, :create, :update, :destroy]
      resources :activities, only: [:destroy]
      ## resources :guests
    end
  end
end
