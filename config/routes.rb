Rails.application.routes.draw do
  root to: 'links#index'
 
  resources :users, only: [:new, :create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#destroy'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :links, only: [:index, :create, :update]
    end
  end
end
