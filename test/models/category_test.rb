require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  should have_many(:quizzes)

  should validate_presence_of(:name)
end
