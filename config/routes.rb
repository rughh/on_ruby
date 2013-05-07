OnRuby::Application.routes.draw do
  resources :users
  resources :locations

  resources :events do
    post 'add_user',  on: :member
    resources :materials
    resources :topics
    resources :participants
  end

  resources :topics do
    resources :likes
  end
  get 'wishes/:slug' => redirect('/topics/%{slug}')

  scope '/auth' do
    get '/:provider/callback',       to: 'sessions#create'
    get '/failure',                  to: 'sessions#failure'
    get '/destroy_user_session',     to: 'sessions#destroy_user_session', as: :destroy_user_session
    get '/destroy_session',          to: 'sessions#destroy',              as: :destroy_session
    get '/login/:provider',          to: 'sessions#auth',                 as: :auth,                 defaults: { provider: 'twitter' }
    get '/offline_login/:nickname',  to: 'sessions#offline_login' if Rails.env.development?
  end

  constraints subdomain: "www" do
    get '/', to: 'labels#index', as: :labels
  end

  get '/home/settings',   to: 'home#settings',  as: :settings
  get '/sitemap/:label',  to: 'misc#sitemap',   as: :sitemap, format: :xml
  get '/api',             to: 'api#index'

  root to: "home#index"

  ActiveAdmin.routes(self)
  # make the logout of rails-admin functional
  get '/admin/logout', to: 'sessions#destroy', as: :destroy_admin_user_session

  get '/*tail' => redirect("/home/labels")
end
