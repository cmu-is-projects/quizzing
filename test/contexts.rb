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
end

