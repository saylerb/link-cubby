Rails.application.routes.draw do
  root to: 'links#index'
 
  resources :users, only: [:new]
end
