
require 'sets/user_contexts'
require 'sets/division_contexts'
require 'sets/student_contexts'
require 'sets/organization_contexts'
require 'sets/quiz_contexts'
require 'sets/team_contexts'
require 'sets/coach_contexts'
require 'sets/event_contexts'
require 'sets/organization_student_contexts'
require 'sets/student_quiz_contexts'
require 'sets/student_team_contexts'
require 'sets/quiz_team_contexts'
require 'sets/team_coach_contexts'
require 'sets/extended_quizzes_contexts'
require 'sets/category_contexts'
require 'sets/indiv_standing_contexts'
require 'sets/team_standing_contexts'

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
  include Contexts::IndivStandingContexts
  include Contexts::TeamStandingContexts
end
