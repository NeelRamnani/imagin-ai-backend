Rails.application.routes.draw do
  # Contacts resource for creating contacts
  resources :contacts, only: [:create]

  # Routes for password reset functionality
  post 'forgot_password', to: 'password_resets#create'
  get 'reset_password/:token', to: 'password_resets#edit', as: :edit_reset_password
  patch 'reset_password/:token', to: 'password_resets#update'

  # Devise routes for user authentication and registration
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup',
    password: 'users/passwords' # Corrected line for password route
  }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # API namespace for images
  namespace :api do
    resources :images, only: [:create]
  end
  namespace :api do
    resources :images, only: [:index]  # Define only the index action for fetching images
  end
  # Custom routes for Users controller
  put '/users/update_password', to: 'users#update_password'
  put '/users/update', to: 'users#update'
  get '/users/name', to: 'users#name'
  get '/users/details', to: 'users#details'

  # Route to show user profile
  get '/user', to: 'users#show'
end
