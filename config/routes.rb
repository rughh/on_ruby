HamburgOnRuby::Application.routes.draw do
  resources :users

  resources :materials

  resources :topics

  resources :participants

  resources :events

  resources :locations
  
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/destroy_session', :to => 'sessions#destroy', :as => :destroy_session
  match '/auth/twitter', :as => :auth
  root :to => "pre#index"

end
