require './test/user_contexts'
require './test/division_contexts'
require './test/student_contexts'
require './test/organization_contexts'
require './test/quiz_contexts'
require './test/team_contexts'
require './test/coach_contexts'
require './test/event_contexts'

module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::UserContexts
  include Contexts::StudentContexts
  include Contexts::OrganizationContexts
  include Contexts::EventContexts
  include Contexts::DivisionContexts
  include Contexts::TeamContexts
  include Contexts::CoachContexts
  include Contexts::QuizContexts
  
end