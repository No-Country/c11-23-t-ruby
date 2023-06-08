Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  get "home/index"

  get 'loans', to: 'pages#loans'
  root to: "pages#home"

  resources :accounts do
    patch :trigger, on: :member
    resources :transactions, only: [ :new, :create ] do
      get :deposit, on: :collection
      get :transfer, on: :collection
      get :withdraw, on: :collection
    end

    resources :loans, only: [ :new, :create ] do
      patch :trigger, on: :member
    end
  end
end
