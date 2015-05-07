class HomeController < ApplicationController
  def home
    # all events for right now
    @events = Event.all 
    @upcoming_events = Event.upcoming.chronological.to_a

    @divisions = Division.all.active

    if(current_user.role == "coach")
      @cur_coach = current_user.coach
      @active_teams = @cur_coach.nil? ? Team.all.active : Team.all.where(organization_id: @cur_coach.organization_id).active

    # if(current_user.role == "coach")
    #   @active_teams = Team.where(organization_id: current_user.coach.organization_id).active

    end
    @inactive_students = Student.all.inactive
    if current_user.role?(:coach)
      @new_students = Student.new_students(current_user.coach.organization)
    end
    @student_team = StudentTeam.new

    if current_user.role?(:coach)
    @active_teams = current_user.coach.organization.teams.active
    end

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
