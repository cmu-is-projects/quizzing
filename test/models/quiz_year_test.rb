require 'test_helper'

class QuizYearTest < ActiveSupport::TestCase
#set up context
  context "Creating a Quiz Year context" do
    setup do
      create_organizations
      create_events
    end

    teardown do
      delete_organizations
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

    should "show that there is one past event in total" do
      yr = QuizYear.new
    	assert_equal 1, yr.completed_events.size
    end

    should "show that there are three events in total this year" do
      yr = QuizYear.new
    	assert_equal 3, yr.this_yr_events.size
    end

  end
end