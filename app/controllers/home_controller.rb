class HomeController < ApplicationController
  def home
    # all events for right now
    @events = Event.all 
    @upcoming_events = Event.upcoming.chronological.to_a
    if(current_user.role != "guest")
      @active_teams = Team.all.where(organization_id: current_user.coach.organization_id).active
    end
    @inactive_students = Student.all.inactive
    @new_students = Student.new_students
    @student_team = StudentTeam.new


    # respond_to do |format|
    #   format.html # show.html.erb
    #   format.json
    #   format.js
    # end
  end

  def display
    # new students without a team
    @new_students = Student.new_students
   
    @student = Student.new

    #@divisions = @student.current_organization.teams.to_a.division


    # all possible active teams that are division and size appropriate
    #@possible_teams = Team.active.not_at_capacity(@student.organization, @student.div)
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end
