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
      format.html { render template: 'students/edit', locals:{primary: "form", sidebar: "student_teams"} }
      format.json { render json: @student_team.errors, status: :unprocessable_entity }
    end
    # else
    #   format.html { render action: 'new' }
    #   format.json { render json: @student_team.errors, status: :unprocessable_entity }
    # end
  end

  private
  def student_team_params
    params.require(:student_team).permit(:is_captain, :active, :team_id, :student_id)
  end
      
end
