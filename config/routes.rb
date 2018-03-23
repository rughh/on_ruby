OnRuby::Application.routes.draw do
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

  # add typus custom actions because it's broken for rails 5
  scope 'admin', {module: :admin, as: 'admin'} do
    post '/highlights/disable', to: 'highlights#disable'
    post '/topics/add_to_next_event', to: 'topics#add_to_next_event'
    post '/events/duplicate', to: 'events#duplicate'
    post '/events/publish', to: 'events#publish'
    post '/events/send_ios_push_notification', to: 'events#send_ios_push_notification'
  end

  scope '/auth' do
    get '/:provider/callback',       to: 'sessions#create'
    get '/failure',                  to: 'sessions#failure'
    get '/destroy_session',          to: 'sessions#destroy',  as: :destroy_session
    get '/login/:provider',          to: 'sessions#auth',     as: :auth
    get '/offline_login/:nickname',  to: 'sessions#offline_login' if Rails.env.development?
  end

  constraints MainDomainConstraint.new do
    get '/', to: 'labels#index', as: :labels
  end

  scope '/api' do
    get '/', to: 'api#index', as: :api
    get '/flush', to: 'api#flush'
  end

  root to: "home#index"

  match '*path.php', via: :all, to: -> (env) { [302, {"Location" => "http://www.youporn.com/"}, ["fuck yourself!"]] }
  match '*path', via: :all, constraints: -> (request) { request.path !~ %r[\A/admin] }, to: -> (env) { [404, {"Content-Type" => "text/html"}, ["not found"]] }
end
