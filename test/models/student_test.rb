require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # test relationships
  should have_many(:organization_students)
  should have_many(:organizations).through(:organization_students)
  should have_many(:student_teams)
  should have_many(:teams).through(:student_teams)
  should have_many(:student_quizzes)
  should have_many(:quizzes).through(:student_quizzes)
end
