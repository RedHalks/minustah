Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'welcome#index'
  devise_for :users

  namespace :welcome do
    get :index
  end

  resources :cash_flows, except: [:show]
  resources :invoices, except: [:show]
  resources :members, except: [:show, :destroy]
end
