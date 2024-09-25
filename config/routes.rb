Rails.application.routes.draw do
  devise_for :users

  root 'employees#index'

  resources :employees
  resources :departments
  resources :spendings

  get 'reports', to: 'reports#index'

  # Other routes
end
