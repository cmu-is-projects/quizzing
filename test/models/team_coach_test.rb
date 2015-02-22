require 'test_helper'

class TeamCoachTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:team)
  should belong_to(:coach)
end
