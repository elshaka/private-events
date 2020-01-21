Rails.application.routes.draw do
  root 'events#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/profile', to: 'users#show'

  resources :events, except: [:index, :destroy] do
    member do
      post 'join'
      post 'leave'
    end
  end
end
