Rails.application.routes.draw do
  resources :contacts, only: [:create]

  post 'forgot_password', to: 'password_resets#create'
  get 'reset_password/:token', to: 'password_resets#edit', as: :edit_reset_password
  patch 'reset_password/:token', to: 'password_resets#update'
  
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  resources :users, only: [:show] do
    put 'update_password', on: :collection
  end
  
  resources :users, only: [:show]
  put '/users/update_password', to: 'users#update_password'
  
  get 'user', to: 'users#show'


end