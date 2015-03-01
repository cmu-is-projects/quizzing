require 'test_helper'

class QuizYearTest < ActiveSupport::TestCase
#set up context
  include Contexts::QuizYearContexts
  context "Creating a Quiz Year context" do
    setup do
      create_events
    end

    teardown do
      delete_events
    end

    should "show that there are zero past event in total" do
    	assert_equal 0, Event.past.size 
    end

    should "show that there are four upcoming events in total" do
    	assert_equal 4, Event.upcoming.size
    end

    #unable to test this
    #should "shows that there are three events for this academic quizzing year" do
    	#@quizyr = FactoryGirl.create(:quizyear)
    	#assert_equal 3, QuizYear.this_yr_events.size
    #end

  end
end