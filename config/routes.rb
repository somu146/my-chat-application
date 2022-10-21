Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'home#index'
  resources :conversations
  resources :messages
  resources :groups
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
