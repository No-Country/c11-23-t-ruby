Rails.application.routes.draw do
  devise_for :users
  get "home/index"

  get 'dashboard', to: 'pages#dashboard'
  root to: "pages#home"

  resources :accounts do
    patch :trigger, on: :member
    resources :transactions, only: [ :create ] do
      get :deposit, on: :member
    end
  end
end
