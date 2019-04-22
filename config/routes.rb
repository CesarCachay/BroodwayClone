Rails.application.routes.draw do
  # devise_for :users
  resources :plays
  root 'plays#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # get ‘auth/:provider/callback’, to: ‘sessions#googleAuth’
  # get ‘auth/failure’, to: redirect(‘/’)
end
