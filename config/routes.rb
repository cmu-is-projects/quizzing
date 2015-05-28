Quizzing::Application.routes.draw do

  # generated routes
  resources :coaches
  resources :events
  resources :organizations
  resources :quizzes
  resources :student_teams
  resources :sessions
  resources :students
  resources :teams
  resources :users
  resources :quizzes
  resources :dashboards
  resources :settings
  resources :standings

  # named routes

  get "standings/individual" => "standings#individual", as: :indiv_standings
  get "standings/team" => "standings#team", as: :team_standings

  get 'user/edit' => 'users#edit', as: :edit_current_user
  get 'login' => 'sessions#new', as: :login
  get 'logout' => 'sessions#destroy', as: :logout
  post   'login'   => 'sessions#create', as: :session_create
  delete 'logout'  => 'sessions#destroy'


  patch 'active/:id' => 'students#active', as: :active
  patch 'inactive/:id' => 'students#inactive', as: :inactive
  patch 'toggle_student/:id' => 'students#toggle', as: :toggle

  get 'home' => 'home#home', as: :home

  # post "student_teams/:id" => 'students#create_student_team', as: :create_student_team
  # patch "student_teams/:id" => 'students#update_student_team', as: :update_student_team

  # Set the root url
  root to: 'home#home'

  # default (error_handling)


end
