HamburgOnRuby::Application.routes.draw do

  resources :users

  resources :events do
    get 'rss', :on => :collection
    get 'add_user', :on => :member
    resources :materials
    resources :topics
    resources :participants
  end
  
  resources :locations
  
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'
  match '/auth/destroy_session', :to => 'sessions#destroy', :as => :destroy_session
  match '/auth/twitter', :as => :auth
  
  root :to => "events#info"
end
