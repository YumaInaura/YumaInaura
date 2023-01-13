Rails.application.routes.draw do
  resources :exes
  resources :messages
  resources :sses
  devise_for :users
  # devise_for :users, :controllers => {
  #   :confirmations => 'users/confirmations',
  #   :registrations => 'users/registrations',
  #   :sessions => 'users/sessions',
  #   :passwords => 'users/passwords'
  #  }

  resources :foos
  resources :examples
  root "examples#index"
end
