# frozen_string_literal: true

OnRuby::Application.routes.draw do
  namespace :admin do
    resources :events do
      post :duplicate, on: :collection
      post :connect, on: :member
    end
    resources :authorizations
    resources :highlights
    resources :jobs
    resources :likes
    resources :locations
    resources :materials
    resources :participants
    resources :topics
    resources :users

    root to: "events#index"
  end

  get 'image/:timestamp/:model_name/:model_id/*filename' => 'images#show', as: :image_dispatch

  resource :sitemap, only: :show

  resources :users do
    get :calendar, on: :member
  end

  resources :locations do
    get :none, on: :collection
  end

  resources :events do
    resources :materials
    resources :topics
    resources :participants
  end

  resources :topics do
    resources :likes
  end

  scope '/auth' do
    get '/',                         to: 'sessions#index', as: :login
    get '/:provider/callback',       to: 'sessions#create'
    get '/failure',                  to: 'sessions#failure'
    get '/destroy_session',          to: 'sessions#destroy', as: :destroy_session
    get '/offline_login/:nickname',  to: 'sessions#offline_login' if Rails.env.development?
  end

  constraints MainDomainConstraint.new do
    get '/', to: 'labels#index', as: :labels
  end

  scope '/api' do
    get '/', to: 'api#index', as: :api
    get '/flush', to: 'api#flush', as: :flush
  end

  root to: "home#index"

  match '*path.php', via: :all, to: ->(_env) { [302, { "Location" => "http://www.youporn.com/" }, ["fuck yourself!"]] }
  match '*path', via: :all, constraints: ->(request) { request.path !~ %r[\A/admin] }, to: ->(_env) { [404, { "Content-Type" => "text/html" }, ["not found"]] }
end
