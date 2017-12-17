Rails.application.routes.draw do
    
    root 'application#welcome'
    
    resources :users
    resources :attractions
    
    get '/signin' => 'sessions#login'
    post '/login' => 'sessions#create'
    post '/logout' => 'sessions#destroy'
    post '/signup' => 'users#create'
end