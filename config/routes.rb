OnRuby::Application.routes.draw do

  ActiveAdmin.routes(self)
  # make the logout of rails-admin functional
  match '/admin/logout', to: 'sessions#destroy', as: :destroy_admin_user_session

  resources :wishes do
    resources :votes
  end

  resources :users
  resources :locations

  # legacy urls
  match '/events/rss', to: 'events#index', defaults: {format: :xml}

  resources :events do
    post 'add_user',  on: :member
    resources :materials
    resources :topics
    resources :participants
  end

  resource :mobile, controller: :mobile, defaults: { format: :mobile } do
    get 'settings'
  end

  scope '/auth' do
    get '/:provider/callback',       to: 'sessions#create'
    get '/failure',                  to: 'sessions#failure'
    get '/destroy_user_session',     to: 'sessions#destroy_user_session', as: :destroy_user_session
    get '/destroy_session',          to: 'sessions#destroy',              as: :destroy_session
    get '/login/:provider',          to: 'sessions#auth',                 as: :auth,                 defaults: { provider: 'twitter' }
    get '/offline_login/:nickname',  to: 'sessions#offline_login' if Rails.env.development?
  end

  match '/home/labels', to: 'home#labels',  as: :labels
  match '/sitemap.xml', to: 'misc#sitemap', as: :sitemap, format: :xml
  match '/api',         to: 'api#index'

  root to: "home#index"

  match '/*tail' => redirect("/home/labels")
end
