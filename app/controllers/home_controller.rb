class HomeController < ApplicationController
  def home
  	# all events for right now
  	@events = Event.all 
    @upcoming_events = Event.upcoming.chronological.to_a

    # new students without a team
    @new_students = Student.new_student.alphabetical.to_a

    # all possible active teams that are division and size appropriate
    #@possible_teams = @student.
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end
