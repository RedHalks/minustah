Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'welcome#index'
  devise_for :users

  namespace :welcome do
    get :index
    get :build_invoices
  end

  resources :cash_flows, except: [:show]
  resources :invoices, except: [:show]
  namespace :invoices do
    resource :batchs, only: [:new, :create]
  end
  resources :members, except: [:show, :destroy] do
    resources :invoices, except: [:show, :destroy], controller: 'members/invoices'
    resources :cash_flows, except: [:show, :destroy], controller: 'members/cash_flows'
  end

  namespace :reports do
    namespace :invoices do
      get :paid
    end
    namespace :cash_flows do
      get :monthly
    end
  end
end
