class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    # if(current_user.role == "coach")
    #   @teams = current_user.coach.organization.teams
    # else
    #   @teams = Team.all
    # end
    @current_user = @current_user
    @teams = Team.all
    @active_teams = @teams.active.sort_by! {|n| n.name}
    @top_standings = TeamStanding.for_juniors(7)
    @inactive_teams = @teams.inactive.sort_by! {|n| n.name}
    @divisions = @teams.active.map {|d| d.division}.uniq
    @junior_teams = TeamStanding.for_juniors.map{|j| j.team}.sort_by! {|n| n.name}.first(10)
    @senior_teams = TeamStanding.for_seniors.map{|j| j.team}.sort_by! {|n| n.name}.first(10)
    @seniorb_teams = TeamStanding.for_seniorb.map{|j| j.team}.sort_by! {|n| n.name}.first(10)
    @junior_standings = TeamStanding.for_juniors(7)
    @senior_standings = TeamStanding.for_seniors(7)
    @seniorb_standings = TeamStanding.for_seniorb(7)
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @teams =Team.all
    @team_standing = TeamStanding.for_team(@team)
    @students = @team.current_students
    @students_by_position = @students.sort_by {|s| s.indiv_standing.position} 
    @quiz_year = QuizYear.new
    @completed_events = @quiz_year.completed_events
    @upcoming_events = @quiz_year.this_yr_events - @quiz_year.completed_events 
    @team_quiz = QuizTeam.for_team(@team) #quizzes for the team
    @declared_num_rounds = 6
    @year_team = YearTeam.new(@team)
    @accuracy_percentage = (@year_team.total_accuracy*100.0).round(1)
    @top_four = TeamStanding.show_top_four(@team)


    #line graph for performances
    @x_axis = YearTeam.find_scored_events_for_year(@quiz_year).map {|e| e.start_date.strftime('%b')}
    #y_axis for team
    @year_quizzes = YearTeam.find_scored_events_for_year(@quiz_year).map
    @events = @year_quizzes.map{ |e| EventTeam.new(@team, e)}
    @performance = @events.map{|e| e.total_points}
    #y_axis for highest team score 
    @top_scores = EventSummary.for_division(@team.division).chronological.map{|e| e.max_team_points}
    #y_axis for average team score
    @average_scores = EventSummary.for_division(@team.division).chronological.map{|e| e.avg_team_points}

    @performance_chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => "Team Performance")
      f.xAxis(:categories => @x_axis)
      f.series(:name => @team.name + " Performance", :yAxis => 0, :color => "#0d47a1", :data => @performance)
      f.series(:name => "Top " + @team.division.name.capitalize[0...-1] + " Team Scores", :color => "#00bcd4", :yAxis => 0, :data => @top_scores)
      f.series(:name => "Averaged Team Scores for "+ @team.division.name.capitalize[0...-1] + " Division", :yAxis => 0, :color => "#a6b8ba", :data => @average_scores)
      f.yAxis [
        {:title => {:text => "Quiz Scores", :margin => 70} }
      ]
      f.chart({:defaultSeriesType=>"line"})
    end 

    #bar graph for individual team members
    @students.each do |s|
      @student_performance = @year_quizzes.map{ |e| EventQuizzer.new(s, e)}.map{|p| p.total_points}
      eval %Q{
        @member_chart#{s.id} = LazyHighCharts::HighChart.new('bar') do |f|
          f.title(:text => "Individual Member Scores")
          f.xAxis(:categories => @x_axis)
          f.series(:name => "Score", :yAxis => 0, :data => @student_performance)
          f.yAxis(
            :min => 0, :max => 500
          )
          f.chart({:defaultSeriesType=>"bar"})
        end
      }
    end

  end

  # GET /teams/new
  def new
    if(current_user.role == "guest")
      redirect_to login_url and return
    end
    @edit = false
    @coaches = Coach.all
    @divisions = Division.all
    @organizations = Organization.all
    @students = Student.all
    @team = Team.new

    if current_user.coach.nil?
      @team_organization = Organization.all.first
    else
      @team_organization = current_user.coach.organization
    end
    @team_name = @team_organization.short_name + " " + (@team_organization.teams.count+1).to_s
  end

  # GET /teams/1/edit
  def edit
    if(current_user.role == "guest")
      redirect_to login_url and return
    end
    if(!current_user.role?(:admin) && current_user.coach.organization.id != @team.organization.id)
      redirect_to team_url(@team) and return
    end
    
    @team_organization = @team.organization
    @team_name = @team.name

    @edit = true
    @coaches = Coach.all
    @divisions = Division.all
    @organizations = Organization.all
    @ineligable_students = StudentTeam.all.where(active: true).where("team_id != :t", {t: @team.id}).pluck(:student_id)
    @students = Student.all.where('id NOT IN (?)', @ineligable_students)

    @student_teams = @team.student_teams.where(active: true).to_a
    (0..(4-@student_teams.size)).each do
      @student_teams << @team.student_teams.build
    end
    @team_coaches = @team.team_coaches.where(end_date: nil).to_a
    (0..(0-@team_coaches.size)).each do
      @team_coaches << @team.team_coaches.build
    end
  end

  # POST /teams
  # POST /teams.json
  def create
    if(current_user.role == "guest")
      redirect_to login_url and return
    end
    @coaches = Coach.all
    @divisions = Division.all
    @organizations = Organization.all
    @students = Student.all
    @team = Team.new(team_params)

    unless current_user.coach.nil?
      @team_organization = current_user.coach.organization
      @team_name = @team.organization.short_name + " " + (@team.organization.teams.count+1).to_s
      @team.organization = @team_organization
      @team.name = @team_name
    end
    
    respond_to do |format|
      if @team.save
        format.html { redirect_to edit_team_url(@team), notice: 'Team was successfully created.' }
        format.json { render action: 'show', status: :created, location: @team }
      else
        format.html { render action: 'new' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    if(current_user.role == "guest")
      redirect_to login_url and return
    end
    if(!current_user.role?(:admin) && current_user.coach.organization.id != @team.organization.id)
      redirect_to home_path and return
    end
    @coaches = Coach.all
    @divisions = Division.all
    @organizations = Organization.all
    @students = Student.all

    # We will remove any students that are no longer on the team. To find these
    # students, we subtract OLD - NEW. We then need to use that to remove them 
    # from the original array.
    @team_ps = [] #team params
    @team_ss = [] #team students
    @students_to_add = []
    @students_to_remove = []
    @team_c = nil
    @team_a = true

    team_params.each{|p|
      if( p[0] == "student_teams_attributes")
        p[1].to_a.each do |e|
          @team_ps << e[1][:student_id].to_i unless e[1][:student_id] == "" || @team_ps.include?(e[1][:student_id].to_i)
        end

      elsif( p[0] == "team_coaches_attributes")
        @team_c = p[1]["0"][:coach_id].to_i unless p[1]["0"][:coach_id] == ""
      elsif(p[0] == "active")
        @team_a = (p[1] == "1") # 1 for active, 0 for inactive
      end
    }

    unless @team.student_teams.nil?
      @team.student_teams.active.pluck(:student_id).each do |id|
        @team_ss << id
      end
    end
    @students_to_remove = @team_ss - @team_ps

    StudentTeam.all.active.where(team_id: @team.id).each do |st|
      @students_to_remove.each do |r|
        if(st.student_id == r)
          st.make_inactive
          st.end_date = Date.today
          st.save!
        end
      end
    end

    # To make sure we don't wind up with the same team member twice, we need to
    # add them ourselves.
    @students_to_add = @team_ps - @team_ss

    # respond_to do |format|
    #   if @team.update(team_params)
    #     format.html { redirect_to @team, 
    #       notice: 'Team was successfully updated.'}
    #     format.json { head :no_content }
    #   else
    #     format.html { render action: 'edit' }
    #     format.json { render json: @team.errors, status: :unprocessable_entity }
    #   end


    @students_to_add.each do |s|
      StudentTeam.create(student_id: s, team_id: @team.id) unless s == ""
    end

    @coach_changed = @team.team_coaches.where(end_date: nil).count == 0
    @cur_coach_id = @team_c
    TeamCoach.all.where(team_id: @team.id, end_date: nil).each do |tc|
      @cur_coach_id = tc.coach_id
      # Set the end date for the old coach & create the new one
      if(@cur_coach_id != @team_c)
        tc.end_date = Date.today
        tc.save
        @coach_changed = true
      end
    end
    if(!@team.active)
      @team.active = true
      @team.save!
    end
    if(@coach_changed)
      @team.team_coaches.create!(team_id: @team.id, coach_id: @team_c)
    end

    if(!@team_a)
      @team.student_teams.active.each do |st|
        st.end_date = Date.today
        st.make_inactive
      end
    end

    @team.active = @team_a
    @team.save!

    respond_to do |format|    
      format.html { redirect_to @team, notice: 'Team was successfully updated.'}
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    if(current_user.role == "guest")
      redirect_to login_url and return
    end
    if(current_user.coach.organization.id != @team.organization.id)
      redirect_to home_path and return
    end
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # TODO: Remove editing of name, division, and organization
    def team_params
      params.require(:team).permit(:active,
                                   :division_id,
                                   :students,
                                   team_coaches: [:coach_id],
                                   team_coaches_attributes: [:coach_id],
                                    student_teams_attributes: [:student_id]
                                   )
    end
end
