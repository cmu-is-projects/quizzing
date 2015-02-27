module Contexts
  module QuizYearContexts

  	def create_events
  		@event1 = FactoryGirl.create(:event)
  		@event2 = FactoryGirl.create(:event, start_date: Date.new(2016,5,5), end_date: Date.new(2016,5,5))
  		@event3 = FactoryGirl.create(:event, start_date: Date.new(2015,7,31), end_date: Date.new(2015,7,31))
      @event4 = FactoryGirl.create(:event, start_date: Date.new(2016,8,1), end_date: Date.new(2016,8,1))
  	end

  	def delete_events
  		@event1.delete unless @event1.nil?
  		@event2.delete unless @event2.nil?
  		@event3.delete unless @event3.nil?
      @event4.delete unless @event4.nil?
  	end
  end
end