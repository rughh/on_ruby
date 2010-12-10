HamburgOnRuby::Application.routes.draw do
  resources :users

  resources :participants do
    get 'add_user', :on => :member
  end

  resources :events do
    resources :materials
    resources :topics
  end
  match 'events.rss', :to => 'events#index', :as => 'rss'
  
  resources :locations
  
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'
  match '/auth/destroy_session', :to => 'sessions#destroy', :as => :destroy_session
  match '/auth/twitter', :as => :auth
  
  root :to => "events#show"

end
