Quizzing::Application.routes.draw do

  # generated routes
  resources :coaches
  resources :events
  resources :organizations
  resources :quizzes
  resources :student_teams
  resources :students
  resources :teams
  resources :users
  resources :quizzes
  resources :dashboards
  resources :settings
  resources :divisions
  resources :categories
  #resources :standings

  # NAMED ROUTES
  # standings routes
  get "standings" => "standings#index", as: :standings

  get "indiv_standings" => "indiv_standings#index", as: :indiv_standings
  get "indiv_standings/juniors" => "indiv_standings#juniors", as: :indiv_standings_j
  get "indiv_standings/seniors" => "indiv_standings#seniors", as: :indiv_standings_s
  get "indiv_standings/seniorb" => "indiv_standings#seniorb", as: :indiv_standings_sb

  get "team_standings" => "team_standings#index", as: :team_standings
  get "team_standings/juniors" => "team_standings#juniors", as: :team_standings_j
  get "team_standings/seniors" => "team_standings#seniors", as: :team_standings_s
  get "team_standings/seniorb" => "team_standings#seniorb", as: :team_standings_sb

  get "update_area_standings" => "settings#update_area_standings", as: :update_area_standings
  get "update_indiv_standings" => "settings#update_indiv_standings", as: :update_indiv_standings
  get "update_team_standings" => "settings#update_team_standings", as: :update_team_standings

  # dashboards and settings

  get "coach_dashboard" => "coaches#index", as: :coach_dashboard
  get "area_admin_dashboard" => "home#area_admin_dashboard", as: :area_admin_dashboard
  get "admin_dashboard" => "home#index", as: :admin_dashboard

  # get "coach_settings" => "coaches#index", as: :coach_settings
  # get "area_admin_settings" => "home#index", as: :area_admin_settings
  # get "admin_settings" => "home#index", as: :admin_settings

  # Search stuff
  get "search" => "searches#index", as: :search_students

  #New page for event schedule
  get "events/schedule/:id" => "events#schedule", as: :schedule

  # authentication routes
  get 'user/edit' => 'users#edit', as: :edit_current_user
  get 'login' => 'sessions#new', as: :login
  get 'logout' => 'sessions#destroy', as: :logout
  post   'login'   => 'sessions#create', as: :session_create
  delete 'logout'  => 'sessions#destroy'
  resources :sessions
  resources :password_resets

  # named routes
  get 'home' => 'home#home', as: :home
  get 'home/coaches' => 'home#home', as: :coach_list
  #get "standings/individual" => "standings#individual", as: :indiv_standings
  #get "standings/team" => "standings#team", as: :team_standings
  patch 'active/:id' => 'students#active', as: :active
  patch 'inactive/:id' => 'students#inactive', as: :inactive
  patch 'toggle_attendance/:id' => 'student_teams#toggle', as: :toggle
  patch 'toggle_division/:id' => 'divisions#toggle_division', as: :toggle_division
  patch 'toggle_quiz_question/:id' => 'categories#toggle_quiz_question', as: :toggle_quiz_question
  patch 'toggle_organization/:id' => 'organizations#toggle_organization', as: :toggle_organization
  patch 'toggle_team/:id' => 'teams#toggle_team', as: :toggle_team
  patch 'toggle_student/:id' =>'students#toggle_student', as: :toggle_student
  patch 'toggle_coach/:id' => 'coaches#toggle_coach', as: :toggle_coach
  # patch 'toggle_student/:id' => 'students#toggle', as: :toggle

  # post "student_teams/:id" => 'students#create_student_team', as: :create_student_team
  # patch "student_teams/:id" => 'students#update_student_team', as: :update_student_team

  # Set the root url
  root to: 'home#home'

  # default (error_handling)


end
