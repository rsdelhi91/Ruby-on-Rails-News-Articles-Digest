Rails.application.routes.draw do
  
  # Root is the unauthenticated path
  root 'sessions#unauth'

  # Sessions URL
  get 'sessions/unauth', to: 'sessions#unauth', as: :login
  post 'sessions/login', as: :signin
  delete 'sessions/logout', as: :logout

  # Resourceful routes for Articles
  resources :articles
  get '/refresh', to: 'articles#refresh', as: 'refresh'
  get '/interests', to: 'articles#my_interests', as: 'interests'
  resources :users, only: [:create,:new,:update,:destroy,:edit]
end
