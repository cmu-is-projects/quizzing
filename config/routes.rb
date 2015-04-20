Quizzing::Application.routes.draw do
  # generated routes
  resources :coaches
  resources :events
  resources :organizations
  resources :quizzes
  resources :sessions
  resources :students
  resources :teams
  resources :users

  # named routes
  get 'user/edit' => 'users#edit', as: :edit_current_user
  get 'login' => 'sessions#new', as: :login
  get 'logout' => 'sessions#destroy', as: :logout
  post   'login'   => 'sessions#create', as: :session_create
  delete 'logout'  => 'sessions#destroy'

  # Set the root url
  root to: 'home#home', as: :home


  # default (error_handling)


end
