Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }, except: :create
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  resources :admin
  resources :stocks

  post 'create_user' => 'admin#create', as: :create_user
  get 'approve_user/:id' => 'admin#approve', as: :approve_user
  post 'cash_in' => 'stocks#cash_in', as: :cash_in
  get 'payment' => 'stocks#payment', as: :payment
  post 'add_stock' => 'stocks#add_stock', as: :add_stock
  post 'sell_stock'=> 'stocks#sell_stock', as: :sell_stock
  get 'portfolio' => 'user#portfolio', as: :portfolio
end
