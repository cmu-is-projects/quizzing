class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
    @divisions = Division.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @divisions = Division.all
    @teams = Team.all
  end

  # GET /teams/new
  def new
    if(current_user.role == "guest")
      redirect_to login_url and return
    end
    @coaches = Coach.all
    @divisions = Division.all
    @organizations = Organization.all
    @students = Student.all
    @team = Team.new

    unless current_user.coach.nil?
      @team.organization = current_user.coach.organization
      @team.name = @team.organization.short_name + " " + (@team.organization.teams.count+1).to_s
    end
  end

  # GET /teams/1/edit
  def edit
    if(current_user.role == "guest")
      redirect_to login_url and return
    end
    @coaches = Coach.all
    @divisions = Division.all
    @organizations = Organization.all
    @students = Student.all

    @student_teams = @team.student_teams.where(active: true).to_a
    (0..(4-@student_teams.size)).each do
      @student_teams << @team.student_teams.build
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

    team_params.each{|p|
      if( p[0] == "student_teams_attributes")
        p[1].to_a.each do |e|
          @team_ps << e[1][:student_id].to_i unless e[1][:student_id] == ""
        end

      elsif( p[0] == "team_coaches")
        @team_c = p[1][:coach_id].to_i unless p[1][:coach_id] == ""
      end
    }

    unless @team.students.nil?
      @team.students.pluck(:id).each do |id|
        @team_ss << id
      end
    end
    @students_to_remove = @team_ss - @team_ps

    StudentTeam.all.active.where(team_id: @team.id).each do |st|
      @students_to_remove.each do |r|
        if(st.student_id == r)
          st.make_inactive
        end
      end
    end

    # To make sure we don't wind up with the same team member twice, we need to
    # add them ourselves.
    @students_to_add = @team_ps - @team_ss

    team_params[:student_teams_attributes] = nil

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
    if(@coach_changed)
      @team.team_coaches.create!(coach_id: @team_c)
    end

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
      params.require(:team).permit(:name,
                                   :active,
                                   :division_id,
                                   :organization_id,
                                   :students,
                                   team_coaches: [:coach_id],
                                    student_teams_attributes: [:student_id]
                                   )
    end
end
