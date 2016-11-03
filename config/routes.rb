Rails.application.routes.draw do
  get 'users/new'

  root 'welcome#index'

  resources :users
  resources :rides
  resources :attractions

  get '/signin', to: 'sessions#new', as: :new_session
end