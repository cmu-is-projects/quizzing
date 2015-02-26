require 'test_helper'

class QuizTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:event)
  should belong_to(:division)
  should have_many(:student_quizzes)
  should have_many(:students).through(:student_quizzes)
  should have_many(:quiz_teams)
  should have_many(:teams).through(:quiz_teams)
end
