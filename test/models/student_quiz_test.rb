require 'test_helper'

class StudentQuizTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:student)
  should belong_to(:quiz)

  context "Creating a Student Quiz context" do
  	setup do
  		create_students
  		create_quizzes
  	end

  	teardown do
  		delete_quizzes
  		delete_students
  	end

  	should "verify that student is active in the system" do
  		bad_student = FactoryGirl.build(:student_quiz, student: @stud3, quiz: @quiz)
  		deny bad_student.valid?
  	end

  	should "verify that quiz is active in the system" do
  		bad_quiz = FactoryGirl.build(:student_quiz, student: @stud1, quiz: @quiz_inactive)
  		deny bad_quiz.valid?
  	end
end
end
