Apolloio::Application.routes.draw do
  root to: "landing#index"

  get "/dashboard", to: 'goals#index', as: :dashboard
  resources :goals, except: :index
  get 'auth/twitter/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
end
