module Contexts
  module EventContexts

  	def create_events
  		@event1 = FactoryGirl.create(:event)
  		@event2 = FactoryGirl.create(:event, start_date: Date.new(2016,5,5), end_date: Date.new(2016,5,5))
  		@event3 = FactoryGirl.create(:event, start_date: Date.new(2015,6,6), end_date: Date.new(2015,6,6))
  	end

  	def delete_events
  		@event1.delete unless @event1.nil?
  		@event2.delete unless @event2.nil?
  		@event3.delete unless @event3.nil?
  	end
  end
end