OnRuby::Application.routes.draw do

  ActiveAdmin.routes(self)

  resources :wishes do
    resources :votes
  end

  resources :users
  resources :locations do
    get 'company', on: :collection
  end

  resources :events do
    get 'rss',        on: :collection, format: :xml
    post 'add_user',  on: :member
    get 'publish',    on: :member
    resources :materials
    resources :topics
    resources :participants
  end

  resource :mobile, controller: :mobile do
    get 'settings'
  end

  match '/auth/:provider/callback',       to: 'sessions#create'
  match '/auth/failure',                  to: 'sessions#failure'
  match '/admin/logout',                  to: 'sessions#destroy',              as: :destroy_admin_user_session # make the logout of rails-admin functional
  match '/auth/destroy_user_session',     to: 'sessions#destroy_user_session', as: :destroy_user_session
  match '/auth/destroy_session',          to: 'sessions#destroy',              as: :destroy_session
  match '/auth/login/:provider',          to: 'sessions#auth',                 as: :auth,                 defaults: { :provider => 'twitter' }
  match '/auth/offline_login/:nickname',  to: 'sessions#offline_login' if Rails.env.development?

  match '/home/labels', to: 'home#labels',  as: :labels
  match '/sitemap.xml', to: 'misc#sitemap', as: :sitemap, format: :xml
  match '/api',         to: 'api#index'

  root to: "home#index"

  match '/*tail' => redirect("/home/labels")
end
