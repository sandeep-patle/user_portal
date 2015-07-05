UserPortal::Application.routes.draw do

  resources :users
  
  resources :sessions, only: [:new, :create, :destroy]

  get 'dashboard' => 'dashboard#index'

  root :to => 'sessions#new'
end
