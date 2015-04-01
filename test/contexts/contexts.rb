require './test/sets/user_contexts'
require './test/sets/division_contexts'
require './test/sets/student_contexts'
require './test/sets/organization_contexts'
require './test/sets/quiz_contexts'
require './test/sets/team_contexts'
require './test/sets/coach_contexts'
require './test/sets/event_contexts'

module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::UserContexts
  include Contexts::DivisionContexts
  include Contexts::StudentContexts
  include Contexts::OrganizationContexts
  include Contexts::QuizContexts
  include Contexts::TeamContexts
  include Contexts::CoachContexts
  include Contexts::EventContexts
end