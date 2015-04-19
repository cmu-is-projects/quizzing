Quizzing::Application.routes.draw do

  # generated routes
  resources :events
  resources :teams
  resources :coaches
  resources :users
  resources :organizations
  resources :students
  resources :quizzes
  resources :student_teams

  # named routes

  patch 'active/:id' => 'students#active', as: :active
  patch 'inactive/:id' => 'students#inactive', as: :inactive
  patch 'toggle_student/:id' => 'students#toggle', as: :toggle

  get "standings/individual" => "standings#individual", as: :indiv_standings


  # Set the root url
  root to: 'home#home', as: :home


  # default (error_handling)


end
