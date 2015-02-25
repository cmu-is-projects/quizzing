require 'test_helper'

class StudentQuizTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:student)
  should belong_to(:quiz)
end
