require 'sets/user_contexts'
require 'sets/division_contexts'
require 'sets/student_contexts'
require 'sets/organization_contexts'
require 'sets/quiz_contexts'
require 'sets/team_contexts'
require 'sets/coach_contexts'
require 'sets/event_contexts'
require 'sets/quiz_year_contexts'
require 'sets/event_quizzer_contexts'

module Contexts
  include Contexts::CoachContexts
  include Contexts::DivisionContexts
  include Contexts::EventContexts
  include Contexts::OrganizationContexts
  include Contexts::QuizContexts
  include Contexts::QuizYearContexts
  include Contexts::StudentContexts
  include Contexts::TeamContexts
  include Contexts::UserContexts
  include Contexts::EventQuizzerContexts
end