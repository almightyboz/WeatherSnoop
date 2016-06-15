Rails.application.routes.draw do

  root 'queries#new'

  resources :queries, only: [:new, :create, :show]
  resources :users, only: [:new, :create, :show]

  get '/session/new' => 'session#new'
  post '/session' => 'session#create'
  get '/logout' => 'session#destroy'

end
