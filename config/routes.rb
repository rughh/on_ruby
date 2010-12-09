HamburgOnRuby::Application.routes.draw do
  resources :users

  resources :participants

  resources :events do
    resources :materials
    resources :topics
  end

  resources :locations
  
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/destroy_session', :to => 'sessions#destroy', :as => :destroy_session
  match '/auth/twitter', :as => :auth
  root :to => "pre#index"

end
