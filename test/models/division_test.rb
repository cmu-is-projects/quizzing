require 'test_helper'

class DivisionTest < ActiveSupport::TestCase
  # test relationships
  should have_many(:quizzes)
  should have_many(:teams)
end
