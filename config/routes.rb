Rails.application.routes.draw do
  get 'users/new'

  root 'welcome#index'

  resources :users
  resources :rides
  resources :attractions, only: [:index, :show, :new, :create]

  post '/attractions/:id', to: 'attractions#take_ride', as: :take_ride

  get '/signin', to: 'sessions#new', as: :new_session

  post '/signin', to: 'sessions#create', as: :create_session

  delete '/logout', to: 'sessions#destroy', as: :destroy_session
end