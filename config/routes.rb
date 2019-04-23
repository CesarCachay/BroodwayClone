Rails.application.routes.draw do
  # devise_for :users
  # get ‘auth/:provider/callback’, to: ‘sessions#googleAuth’
  # get ‘auth/failure’, to: redirect(‘/’)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :plays do
    resources :reviews  
  end
  root 'plays#index'
end
