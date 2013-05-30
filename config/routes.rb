_404 = proc { |env| [404, {"Content-Type" => "text/html"}, ["404"]] }

OnRuby::Application.routes.draw do
  resources :sitemaps, only: :show
  resources :settings, only: :index

  resources :users
  resources :locations

  resources :events do
    post 'add_user', on: :member
    resources :materials
    resources :topics
    resources :participants
  end

  resources :topics do
    resources :likes
  end

  scope '/auth' do
    get '/:provider/callback',       to: 'sessions#create'
    get '/failure',                  to: 'sessions#failure'
    get '/destroy_user_session',     to: 'sessions#destroy_user_session', as: :destroy_user_session
    get '/destroy_session',          to: 'sessions#destroy',              as: :destroy_session
    get '/login/:provider',          to: 'sessions#auth',                 as: :auth,                 defaults: { provider: 'twitter' }
    get '/offline_login/:nickname',  to: 'sessions#offline_login' if Rails.env.development?
  end

  constraints MainDomainConstraint.new do
    get '/', to: 'labels#index', as: :labels
  end

  get '/api', to: 'api#index'

  root to: "home#index"

  ActiveAdmin.routes(self)
  get '/*tail', to: _404
end
