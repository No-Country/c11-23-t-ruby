Rails.application.routes.draw do
  devise_for :users
  get "home/index"

  get 'dashboard', to: 'pages#dashboard'
  root to: "pages#home"

  resources :accounts do
    patch :trigger, on: :member
    resources :transactions, only: [ :create ] do
      get :deposit, on: :member
      get :transfer, on: :member
      get :withdraw, on: :member
    end

    resources :loans, only: [ :new, :create ]
  end
end
