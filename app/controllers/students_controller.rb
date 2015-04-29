class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy, :toggle]

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
    @active_students = Student.active.alphabetical
    @inactive_students = Student.inactive.alphabetical
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @student_teams = StudentTeam.all
    @organization_students = OrganizationStudent.all
    @year_quizzer = YearQuizzer.new(@student)
    @all_student_quizzes = @student.student_quizzes
    @events = Event.all.chronological
    #@num_rounds = @organization_students.to_a.first.quiz.num_rounds
    #@accuracy_percentage = number_to_percentage(@quizzer.total_accuracy*100.0, precision: 1)
    @accuracy_percentage = (@year_quizzer.total_accuracy*100.0).round(1)
  end

  # GET /students/new
  def new
    if(current_user.role == "guest")
      redirect_to login_url and return
    end
    @student = Student.new
    # authorize! :new, @student
    @inactive_students = Student.inactive.alphabetical
  end

  # GET /students/1/edit
  def edit
    if(current_user.role == "guest")
      redirect_to login_url and return
    end
    #@organizations = Organization.active.all
    if @student.current_student_team.is_a? NullStudentTeam
      @student_team = StudentTeam.new
      @collection = @student.current_organization.teams.active.alphabetical
      @team_id = -1
    else
      @student_team = @student.current_student_team
      @collection = @student.current_organization.teams.active.alphabetical.for_division(@student.current_team.division)
      @team_id = @student.current_team.id
    end
  end

  # POST /students
  # POST /students.json
  def create
    if(current_user.role == "guest")
      redirect_to login_url and return
    end
    @student = Student.new(student_params)
    # authorize! :create, @student
      if @student.save
        respond_to do |format|
          @active_teams = Team.all.active
          format.js
        # format.html { redirect_to @student, notice: 'Student was successfully created.' }
        # format.json { render action: 'show', status: :created, location: @student }

        #@student.add_to_organization(current_user.organization)
        @student.add_to_organization(current_user)
        format.html { redirect_to @student, notice: "#{@student.name} has been created." }
        format.json { render action: 'show', status: :created, location: @student }
      end
      else
        format.html { render action: 'new' }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    if(current_user.role == "guest")
      redirect_to login_url and return
    end
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def toggle
    if(current_user.role == "guest")
      redirect_to login_url and return
    end
    @student_team = @student.current_student_team
    if params[:status] == 'inactive'
      @student_team.active = false
    else
      @student_team.active = true
    end
    @student_team.save!
    @student_team = nil
    @active_teams = Team.all.active
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    if(current_user.role == "guest")
      redirect_to login_url and return
    end
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url }
      format.json { head :no_content }
    end
  end

  # def create_student_team
    
  # end

  # def update_student_team
    
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:first_name, :last_name, :grade, :is_captain, :active, :organization_ids, :team_id)
    end
end
