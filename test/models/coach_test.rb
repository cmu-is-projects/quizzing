require 'test_helper'

class CoachTest < ActiveSupport::TestCase
  # validations
  should belong_to(:organization)
  should have_many(:team_coaches)
  should have_many(:teams).through(:team_coaches)
  should belong_to(:user)
  
  should accept_nested_attributes_for(:user).allow_destroy(true)
  should validate_presence_of(:user_id)
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)


end
