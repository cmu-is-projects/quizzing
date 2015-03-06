module Contexts
  module QuizYearContexts

  	def create_events
  		@event1 = FactoryGirl.create(:event)
      @event2 = FactoryGirl.create(:event, start_date: 1.year.from_now.to_date, end_date: 1.year.from_now.to_date)
  		@event3 = FactoryGirl.create(:event, start_date: 2.weeks.from_now.to_date, end_date: 2.weeks.from_now.to_date)
      @event3.update_attribute(:start_date, 2.weeks.ago.to_date)
      @event3.update_attribute(:end_date, 2.weeks.ago.to_date)
  		@event4 = FactoryGirl.create(:event, start_date: Date.new(Date.today.year,7,31), end_date: Date.new(Date.today.year,7,31))
      @event5 = FactoryGirl.create(:event, start_date: Date.new((Date.today.year),8,1), end_date: Date.new((Date.today.year),8,1))
  	end

  	def delete_events
  		@event1.delete unless @event1.nil?
  		@event2.delete unless @event2.nil?
  		@event3.delete unless @event3.nil?
      @event4.delete unless @event4.nil?
  	end
  end
end