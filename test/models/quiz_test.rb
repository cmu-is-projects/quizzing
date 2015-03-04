require 'test_helper'

class QuizTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:category)
  should belong_to(:event)
  should belong_to(:division)
  should have_many(:student_quizzes)
  should have_many(:students).through(:student_quizzes)
  should have_many(:quiz_teams)
  should have_many(:teams).through(:quiz_teams)

  #validations
  should validate_presence_of(:event_id)
  should validate_presence_of(:division_id)
  should validate_presence_of(:round_num)

  include Contexts::QuizContexts
  context "Creating an quiz context" do
    setup do 
      create_quizzes
    end
    
    teardown do
      delete_quizzes
    end

    should "Show that that quiz's active scope works" do
    	assert_equal 4, Quiz.active.size
    	assert_equal [1,2,3,4], Quiz.active.all.map{|q| q.round_num}
    end

    should "show that quiz's inactive scope works" do
    	assert_equal 1, Quiz.inactive.size
    	assert_equal [5], Quiz.inactive.all.map{|q| q.round_num}
    end

    #need to ensure quiz can't be assigned to inactive division/event


  end # contexts
end #class
