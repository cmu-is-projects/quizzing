module Contexts
  module EventContexts
    # assumes create_one_organization method already run...
    def create_one_event
      # creates one event that occurred two weeks in the past
      @event = FactoryGirl.create(:event, organization: @acac, start_date: 2.weeks.from_now.to_date, end_date: 2.weeks.from_now.to_date)
      @event.update_attribute(:start_date, 2.weeks.ago.to_date)
      @event.update_attribute(:end_date, 2.weeks.ago.to_date)
    end

    def delete_one_event
      @event.delete
    end

    def create_prev_year_event
      # creates two event that occured in previous quiz years
      @event4 = FactoryGirl.create(:event, organization: @acac, start_date: 2.weeks.from_now.to_date, end_date: 2.weeks.from_now.to_date)
      @event4.update_attribute(:start_date, 1.year.ago.to_date)
      @event4.update_attribute(:end_date, 1.year.ago.to_date)

      @event5 = FactoryGirl.create(:event, organization: @acac, start_date: 3.weeks.from_now.to_date, end_date: 3.weeks.from_now.to_date)
      @event5.update_attribute(:start_date, 2.years.ago.to_date)
      @event5.update_attribute(:end_date, 2.years.ago.to_date)
    end

    def delete_prev_year_event
      @event4.delete
      @event5.delete
    end

  	def create_events
      create_one_event  # creates a past event that can have scores, etc.
      create_prev_year_event # creates previous quiz year events
  		@event1 = FactoryGirl.create(:event, organization: @acac, start_date: 1.day.from_now.to_date, end_date: 1.day.from_now.to_date)
  		@event2 = FactoryGirl.create(:event, organization: @acac, start_date: 1.year.from_now.to_date, end_date: 1.year.from_now.to_date)
      #@event3 causes student_quizzes with nil fields
  		@event3 = FactoryGirl.create(:event, organization: @acac, start_date: 4.weeks.from_now.to_date, end_date: 4.weeks.from_now.to_date)
  	end

  	def delete_events
      delete_one_event
      delete_prev_year_event
  		@event1.delete
  		@event2.delete
  		@event3.delete
  	end
  end
end