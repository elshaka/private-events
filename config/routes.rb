Rails.application.routes.draw do
  root 'static_pages#home'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/profile', to: 'users#show'

  post '/events/:id/join', to: 'events#join', as: 'join_event'
  post '/events/:id/leave', to: 'events#leave', as: 'leave_event'
  resources :events, except: [:destroy]
end
