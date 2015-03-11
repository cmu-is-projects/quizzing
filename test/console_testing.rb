require 'factory_girl_rails'

require './test/sets/user_contexts'
require './test/sets/division_contexts'
require './test/sets/student_contexts'
require './test/sets/organization_contexts'
require './test/sets/quiz_contexts'
require './test/sets/team_contexts'
require './test/sets/coach_contexts'
require './test/sets/event_contexts'
require './test/sets/organization_student_contexts'
require './test/sets/student_quiz_contexts'
require './test/sets/student_team_contexts'
require './test/sets/quiz_team_contexts'
require './test/sets/team_coach_contexts'

module Contexts
  include Contexts::CoachContexts
  include Contexts::DivisionContexts
  include Contexts::EventContexts
  include Contexts::OrganizationContexts
  include Contexts::QuizContexts
  include Contexts::StudentContexts
  include Contexts::TeamContexts
  include Contexts::UserContexts
  include Contexts::OrganizationStudentContexts
  include Contexts::StudentQuizContexts
  include Contexts::StudentTeamContexts
  include Contexts::QuizTeamContexts
  include Contexts::TeamCoachContexts

  def create_all
    create_divisions
    create_organizations
    create_events
    create_students
    create_users
    create_coaches
    create_teams
    create_organization_students
    create_student_teams
    create_quizzes_for_past_event
    create_quizzes_for_future_event
    create_quiz_teams_for_past_event
    create_quiz_teams_for_future_event
    create_student_quizzes
    create_student_quizzes_with_no_score_yet
    create_team_coaches
  end

  def delete_all
    Division.delete_all
    Organization.delete_all
    Event.delete_all
    Student.delete_all
    Coach.delete_all
    Team.delete_all
    OrganizationStudent.delete_all
    StudentTeam.delete_all
    TeamQuiz.delete_all
    StudentQuiz.delete_all    
  end
end