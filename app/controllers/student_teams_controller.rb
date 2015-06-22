class StudentTeamsController < ApplicationController
  #before_action :set_student_team, on: [:update]
  def update
    @student_team = StudentTeam.find(params[:id])
    respond_to do |format|
      if @student_team.update(student_team_params)
        format.html { redirect_to student_path(@student_team.student), notice: 'Student was successfully updated.' }
        format.json { head :no_content }
      else
        # format.html { render action: 'edit' }
        format.json { render json: @student_team.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def create
    @student_team = StudentTeam.new(student_team_params)

    if @student_team.save
      respond_to do |format|
        format.html { redirect_to home_path, notice: 'Student was successfully updated.' }
        format.json { head :no_content }
      end

    else
      respond_to do |format|
        format.html { render template: 'students/edit', locals:{primary: "form", sidebar: "student_teams"} }
        format.json { render json: @student_team.errors, status: :unprocessable_entity }
    end
    end
    # else
    #   format.html { render action: 'new' }
    #   format.json { render json: @student_team.errors, status: :unprocessable_entity }
    # end
  end

  def toggle
    @student_team = StudentTeam.find(params[:id])
    @coach = Coach.find(params[:coach_id])
    @student_team.present = params[:present] unless params[:present].nil?
    @changed = params[:division] unless params[:division].nil?
    @student_team.save!
    @junior_teams = Team.for_juniors(1000, @coach.organization)
    @senior_teams = Team.for_seniors(1000, @coach.organization)
    @seniorb_teams = Team.for_seniorb(1000, @coach.organization)
  end

  private
  def student_team_params
    params.require(:student_team).permit(:is_captain, :active, :team_id, :student_id)
  end
      
end
