Rails.application.routes.draw do
  resources :examples
  devise_for :users

  root "examples#index"
end
