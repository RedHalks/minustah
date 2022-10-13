Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "members#new"

  resources :cash_flows, except: [:show]
  resources :invoices, except: [:show]
  resources :members, except: [:show, :destroy]
end
