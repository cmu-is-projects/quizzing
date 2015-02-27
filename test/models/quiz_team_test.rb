require 'test_helper'

class QuizTeamTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:quiz)
  should belong_to(:team)
end
