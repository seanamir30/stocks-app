Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }, except: :create
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  resources :admin
  resources :stocks

  post 'create_user' => 'admin#create', as: :create_user
  get 'approve_user/:id' => 'admin#approve', as: :approve_user
  post 'cash_in' => 'home#cash_in', as: :cash_in
end
