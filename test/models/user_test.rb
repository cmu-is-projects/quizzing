require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test relationships
  should have_one(:coach)
end
