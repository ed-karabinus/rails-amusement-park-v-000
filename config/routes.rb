Rails.application.routes.draw do
  get 'users/new'

  root 'welcome#index'

  resources :users, only: [:show, :new, :create]
  resources :attractions, only: [:index, :show, :new, :create, :edit, :update]

  post '/attractions/:id', to: 'attractions#take_ride', as: :take_ride

  get '/signin', to: 'sessions#new', as: :new_session

  post '/signin', to: 'sessions#create', as: :create_session

  delete '/logout', to: 'sessions#destroy', as: :destroy_session
end