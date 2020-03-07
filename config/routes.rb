Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post '/login', to:  'auth#create'
  post '/signup', to: 'users#create'
  get '/profile', to: 'users#profile'
  post '/movies', to: 'movies#create'
  get '/movies', to: 'movies#index'
  get '/movies', to: 'movies#show'
  get '/comments', to: 'comments#index'
  get '/favorites', to: 'favorites#index'
  patch '/users', to: 'users#update'
  # resources :movies

  resources :users do
    resources :movies
    resources :comments
    resources :favorites
  end

  resources :users do #shows all the movies that the user created
   get '/movies', to: 'movies#index'
   get '/comments', to: 'comments#index'
   # get '/favorites', to: 'favorites#index'
 end

end
