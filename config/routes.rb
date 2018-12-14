Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tutorials, only:[:show, :index]
      resources :videos, only:[:show]
    end
  end

  root 'welcome#index'
  get 'tags/:tag', to: 'welcome#index', as: :tag
  get '/register', to: 'users#new'

  namespace :admin do
    get "/dashboard", to: "dashboard#show"
    resources :tutorials, only: [:create, :edit, :update, :destroy, :new] do
      resources :videos, only: [:create]
    end
    resources :videos, only: [:edit, :update, :destroy]

    namespace :api do
      namespace :v1 do
        put "tutorial_sequencer/:tutorial_id", to: "tutorial_sequencer#update"
      end
    end
  end

  get '/auth/github/callback', to: "github#create", as: "github_callback"

  get  '/invite',      to: 'invite#new',    as: 'invite'
  post '/send_invite', to: 'invite#create', as: 'send_invite'

  post   '/add_friend',    to: 'friendships#create',  as: "add_friend"
  # delete '/remove_friend', to: 'friendships#destroy', as: "remove_friend"


  get    '/login',  to: "sessions#new"
  post   '/login',  to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  get '/dashboard',   to: 'users#show'
  get '/about',       to: 'about#show'
  get '/get_started', to: 'get_started#show'

  resources :users, only: [:new, :create, :update, :edit]

  resources :tutorials, only: [:show, :index] do
    resources :videos, only: [:show, :index]
  end

  resources :user_videos, only:[:create, :destroy]

  resources :account_activations, only: [:edit]
end
