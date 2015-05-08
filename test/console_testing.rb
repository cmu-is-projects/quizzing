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
require './test/sets/extended_quizzes_contexts'
require './test/sets/category_contexts'

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
  include Contexts::ExtendedQuizzesContexts
  include Contexts::CategoryContexts

  def create_all
    create_categories
    create_divisions
    create_organizations
    create_events
    create_students
    create_add_students
    create_users
    create_coaches
    create_teams
    create_junior_teams #unused for testing, used for view data
    create_senior_b_teams  #unused for testing, used for view data
    create_organization_students
    create_add_organization_students
    create_student_teams
    create_senior_b_student_teams #unused for testing, used for view data
    create_quizzes_for_past_event
    create_quizzes_for_future_event
    create_quiz_teams_for_past_event
    create_jr_division_quiz_teams #unused for testing, used for view data
    create_senior_b_quiz_teams #unused for testing, used for view data
    create_quiz_teams_for_future_event
    create_student_quizzes
    create_student_quizzes_with_no_score_yet
    create_junior_student_quizzes #unused for testing, used for view data
    create_senior_b_student_quizzes #unused for testing, used for view data
    create_team_coaches
    create_three_more_complete_quiz_contexts
  end

  def delete_all
    Category.delete_all
    Division.delete_all
    Organization.delete_all
    Event.delete_all
    Student.delete_all
    User.delete_all
    Coach.delete_all
    Team.delete_all
    OrganizationStudent.delete_all
    StudentTeam.delete_all
    Quiz.delete_all
    QuizTeam.delete_all
    StudentQuiz.delete_all  
    TeamCoach.delete_all  
  end
end