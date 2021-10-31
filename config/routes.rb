Rails.application.routes.draw do
  get 'orders', action: :index, controller: :orders
  get 'cart', action: :cart, controller: :orders
  resources :products
  devise_for :users, controllers: {
    sessions: 'users/sessions', 
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  resources :users, only: [] do
    resources :orders
  end

  resources :orders, only: [] do
    resources :line_items
  end
  root 'home#index'
end
