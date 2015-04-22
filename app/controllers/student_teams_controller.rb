class StudentTeamsController < ApplicationController
  def update
    @student_team = StudentTeam.find(params[:id])
    respond_to do |format|
      if @student_team.update(student_team_params)
        format.html { redirect_to student_path(@student_team.student), notice: 'Student was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @student_team.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    
  end

  private
  def student_team_params
    params.require(:student_team).permit(:is_captain, :active, :team_id)
  end
      
end
