Apolloio::Application.routes.draw do
  root to: "landing#index"

  resources :goals
  resources :api_accounts, only: :show

  get 'dashboard', to: 'dashboard#index'
  get 'auth/twitter/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

end
