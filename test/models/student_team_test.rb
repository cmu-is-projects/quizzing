require 'test_helper'

class StudentTeamTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:student)
  should belong_to(:team)
end
