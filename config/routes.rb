Rails.application.routes.draw do
  get 'reviews/new'
  get 'reviews/create'

  get 'users/new'
  get 'users/create'


  resources :movies do
    resources :reviews, only: [:new, :create]
  end
  
  resources :users, only: [:new, :create]
  resources :session, only: [:new, :create, :destroy]

  namespace :admin do 
    resources :users
  end

  root to: 'movies#index'
end
