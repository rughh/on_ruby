OnRuby::Application.routes.draw do

  ActiveAdmin.routes(self)
  # make the logout of rails-admin functional
  match '/admin/logout', to: 'sessions#destroy', as: :destroy_admin_user_session

  resources :wishes do
    resources :votes
  end

  resources :users
  resources :locations

  resources :events do
    post 'add_user',  on: :member
    resources :materials
    resources :topics
    resources :participants
  end

  resource :mobile, controller: :mobile do
    get 'settings'
  end

  scope :auth do
    match ':provider/callback',       to: 'sessions#create'
    match 'failure',                  to: 'sessions#failure'
    match 'destroy_user_session',     to: 'sessions#destroy_user_session', as: :destroy_user_session
    match 'destroy_session',          to: 'sessions#destroy',              as: :destroy_session
    match 'login/:provider',          to: 'sessions#auth',                 as: :auth,                 defaults: { provider: 'twitter' }
    match 'offline_login/:nickname',  to: 'sessions#offline_login' if Rails.env.development?
  end

  match '/home/labels', to: 'home#labels',  as: :labels
  match '/sitemap.xml', to: 'misc#sitemap', as: :sitemap, format: :xml
  match '/api',         to: 'api#index'

  root to: "home#index"

  match '/*tail' => redirect("/home/labels")
end
