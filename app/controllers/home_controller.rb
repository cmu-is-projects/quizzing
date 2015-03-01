class HomeController < ApplicationController
  def index
  	# all events for right now
  	@events = Event.all 
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end
