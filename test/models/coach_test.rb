require 'test_helper'

class CoachTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:organization)
  should have_many(:team_coaches)
  should have_many(:teams).through(:team_coaches)
  should belong_to(:user)
  should accept_nested_attributes_for(:user).allow_destroy(true)
end
