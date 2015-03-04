require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:organization)
  should belong_to(:division)
  should have_many(:student_teams)
  should have_many(:students).through(:student_teams)
  should have_many(:team_coaches)
  should have_many(:coaches).through(:team_coaches)

  #validations
  should validate_presence_of_name


end
