class HomeController < ApplicationController
  def home
  	# all events for right now
  	@events = Event.all 
    @upcoming_events = Event.upcoming.chronological.to_a
    @active_teams = Team.all.active
    @inactive_students = Student.all.inactive
  end

  def display
    
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end
