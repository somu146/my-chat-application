Rails.application.routes.draw do
  devise_for :users
  root to: 'conversations#index'
  resources :conversations
  resources :messages
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
