Rails.application.routes.draw do
  get 'orders', action: :index, controller: :orders
  resources :products
  devise_for :users, controllers: {
    sessions: 'users/sessions', 
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  resources :users, only: [] do
    resources :orders
  end
  root 'home#index'
end
