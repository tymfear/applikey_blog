Rails.application.routes.draw do
  root 'sessions#new'

  resources :articles do
    resources :comments, only: %i(create edit update destroy)
  end

  resources :users, only: %i(create edit show update)

  get 'signup', to: 'users#new'
  post 'signin', to: 'sessions#create'
  delete 'signout', to: 'sessions#destroy'
end
