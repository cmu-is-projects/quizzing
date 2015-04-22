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
    @coaches = Coach.all
    @divisions = Division.all
    @organizations = Organization.all
    @students = Student.all
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
    @coaches = Coach.all
    @divisions = Division.all
    @organizations = Organization.all
    @students = Student.all
  end

  # POST /teams
  # POST /teams.json
  def create
    @coaches = Coach.all
    @divisions = Division.all
    @organizations = Organization.all
    @students = Student.all
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
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
    @coaches = Coach.all
    @divisions = Division.all
    @organizations = Organization.all
    @students = Student.all

    # We will remove any students that are no longer on the team. To find these
    # students, we subtract OLD - NEW. We then need to use that to remove them 
    # from the original array.
    @team_ps = []
    @team_ss = []
    @students_to_add = []
    @students_to_remove = []

    team_params.each{|p|
      if( p[0] == "student_teams_attributes")
        p[1].to_a.each do |e|
          @team_ps << e[1][:student_id]
        end
      end
    }

    unless @team.students.nil?
      @teams_ss = @team.students.to_a
    end
    @students_to_remove = @team_ss - @team_ps

    StudentTeam.all.where(team_id: @team.id).each do |st|
      @students_to_remove.each do |r|
        if(st.student_id == r.id)
          st.make_inactive
        end
      end
    end

    # To make sure we don't wind up with the same team member twice, we need to
    # add them ourselves.
    @students_to_add = @team_ps - @team_ss
    team_params[:student_teams_attributes] = nil

lkjdf

    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, 
          notice: 'Team was successfully updated.'}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
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
    def team_params
      params.require(:team).permit(:name,
                                   :active,
                                   :division_id,
                                   :organization_id,
                                   :students,
                                   :team_coaches,
                                    student_teams_attributes: [:student_id]
                                   )
    end
end
