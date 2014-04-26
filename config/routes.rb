MusicAppScaffold::Application.routes.draw do
  resources :users
  resource :session
  
  resources :tracks, shallow: true
  
  resources :albums do 
    resources :tracks, shallow: true
  end

  #these need to be nested. Look up how.
  resources :bands do 
    resources :albums, only: [:index, :new, :create] 
  end
  
  resources :notes
  
end

