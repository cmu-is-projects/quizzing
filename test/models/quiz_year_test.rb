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

    should "show that include? is working" do
      this_year = QuizYear.new
      assert this_year.include?(Date.today)
      deny this_year.include?(2.years.ago.to_date)
      deny this_year.include?(1.year.from_now.to_date)
    end

    should "show that QuizYear with different dates works" do
      old_year = QuizYear.new(2011,2012)
      assert old_year.include?(Date.new(2011,10,1))
      assert old_year.include?(Date.new(2012,2,1))
      deny old_year.include?(2.years.ago.to_date)
      deny old_year.include?(Date.new(2010,10,1))
    end

    should "show that there are zero past event in total" do
    	yr = QuizYear.new
      #should have at least 1 in the context
      
      assert_equal 2, yr.completed_events.size
    end

    should "show that there are four upcoming events in total" do
    	yr = QuizYear.new
      # should have at least 1 in the context
      assert_equal 3, yr.this_yr_events.size
    end

    #unable to test this
    #should "shows that there are three events for this academic quizzing year" do
    	#@quizyr = FactoryGirl.create(:quizyear)
    	#assert_equal 3, QuizYear.this_yr_events.size
    #end

  end
end