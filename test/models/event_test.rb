require 'test_helper'

class EventTest < ActiveSupport::TestCase

  # Relationships
  should have_many(:quizzes)
  should belong_to(:organization)

  #VALIDATONS
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
  should_not allow_value("78").for(:start_time)  
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
      create_one_organization
      create_events
    end

    teardown do
      delete_one_organization
      delete_events
    end

    should "shows that there are four events in chronological order" do
      assert_equal ["#{2.weeks.ago.to_date.strftime("%b %d")}", "#{Date.tomorrow.strftime("%b %d")}", "#{4.weeks.from_now.to_date.strftime("%b %d")}", "#{1.year.from_now.to_date.strftime("%b %d")}"], Event.chronological.all.map{|e| "#{e.start_date.strftime("%b %d")}"}
    end

    should "shows that there are 3 upcoming events and 1 past events" do
      assert_equal 3, Event.upcoming.size
      assert_equal 1, Event.past.size
    end

    should "verify that the organization is active in the system" do
      # test the inactive organization first
      grove_city = FactoryGirl.create(:organization, name: "Grove City Church", short_name: "Grove City", active: false)
      bad_event = FactoryGirl.build(:event, organization: grove_city)
      deny bad_event.valid?
      grove_city.delete
      # test the nonexistent organization
      grove_city = FactoryGirl.build(:organization, name: "Grove City Church", short_name: "Grove City", active: true)
      bad_event = FactoryGirl.build(:event, organization: grove_city)
      deny bad_event.valid?
    end 

    should "not allow end dates that precede start dates" do
      @event.end_date = 3.weeks.ago.to_date
      deny @event.valid?
    end
  end
end
