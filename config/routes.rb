Rails.application.routes.draw do
  get 'current_user', to: 'current_user#index'
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup',
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    invitations: 'users/invitations'
  }

  resources :roles, only: [:list]
  resources :tags
  resources :media_files
  post '/upload', to: 'upload#create'
  
  resources :organizations do
    resources :albums
  end

  namespace :admin do
    resources :albums, controller: 'admin_albums', only: [:index, :show]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
