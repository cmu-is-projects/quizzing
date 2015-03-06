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
      #create_categories
      create_divisions
      create_organizations
      create_events
      create_quizzes
    end
    
    teardown do
      #delete_categories
      delete_quizzes
      delete_events
      delete_organizations
      delete_divisions
    end

    should "Show that that quiz's active scope works" do
    	assert_equal 4, Quiz.active.size
    	assert_equal [1,2,3,4], Quiz.active.all.map{|q| q.round_num}.sort
    end

    should "show that quiz's inactive scope works" do
    	assert_equal 1, Quiz.inactive.size
    	assert_equal [5], Quiz.inactive.all.map{|q| q.round_num}.sort
    end

    #need to ensure quiz can't be assigned to past event
    should "show that quiz can't be assigned to past event" do
      @past_event = FactoryGirl.build(:event, start_time: Time.now, start_date: Date.tomorrow, end_date: Date.tomorrow, num_rounds: 2)
      bad_quiz = FactoryGirl.build(:quiz, division: @division1, event: @past_event)
      deny bad_quiz.valid?
    end


    #test scope by_round
    #need method to ensure uniqueness of event, division, round uniqueness
    #ensure event and division are active in system
    


  end # contexts
end #class
