require 'test_helper'

class EventTest < ActiveSupport::TestCase

  #VALIDATONS
  should have_many(:quizzes)
  should belong_to(:organization)
  should validate_presence_of(:start_date)
  should validate_presence_of(:start_time)
  should validate_presence_of(:num_rounds)
  # START DATE
  should allow_value(Date.today).for(:start_date)
  should allow_value(1.day.from_now.to_date).for(:start_date)
  should_not allow_value(1.day.ago.to_date).for(:start_date)
  should_not allow_value("bad").for(:start_date)
  should_not allow_value(2).for(:start_date)
  should_not allow_value(3.14159).for(:start_date)
  #END_DATE  
  should_not allow_value("bad").for(:end_date)
  should_not allow_value(2).for(:end_date)
  should_not allow_value(3.14159).for(:end_date) 
  #START_TIME
  should allow_value(Time.now).for(:start_time)
  should_not allow_value("am").for(:start_time)
  should_not allow_value("pm").for(:start_time)
  should_not allow_value("bad").for(:start_time)
  #should_not allow_value("1:00").for(:start_time)  
  should_not allow_value(900).for(:start_time)
  #NUM_ROUNDS
  should validate_numericality_of(:num_rounds)
  #unsure of a realistic cap for num_rounds
  should allow_value(120).for(:num_rounds)
  should_not allow_value(0).for(:num_rounds)
  should_not allow_value("bad").for(:num_rounds)
  should_not allow_value(-20).for(:num_rounds)
  should_not allow_value(3.14159).for(:num_rounds)

  #set up context
  context "Creating an Event context" do
    setup do
      create_events
    end

    teardown do
      delete_events
    end

    should "shows that there are three events in chronological order" do
      assert_equal ["#{Date.today.strftime("%b %d")}", "Jun 06", "May 05"], Event.chronological.all.map{|e| "#{e.start_date.strftime("%b %d")}"}
    end

    should "shows that there are 2 upcoming events and 1 past event" do
      @event3.update_attribute(:start_date, 7.days.ago.to_date) # update_attribute will bypass validation
      @event3.update_attribute(:end_date, 2.days.ago.to_date)
      assert_equal 2, Event.upcoming.size
      assert_equal 1, Event.past.size
    end
  end
end
