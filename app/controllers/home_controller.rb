class HomeController < ApplicationController
  def home
  	# all events for right now
  	@events = Event.all 
    @upcoming_events = Event.upcoming.chronological.to_a
    @teams = Team.all
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end
