class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy, :toggle]

  # GET /students
  # GET /students.json
  def index
    if(current_user.role == "coach")
      @students = current_user.coach.organization.students
    else
      @students = Student.all
    end
    @juniors = IndivStanding.for_juniors.map{|j| j.student}.sort_by! {|n| n.last_name}.first(10)
    @seniors = IndivStanding.for_seniors.map{|j| j.student}.sort_by! {|n| n.last_name}.first(10)
    @seniorb = IndivStanding.for_seniorb.map{|j| j.student}.sort_by! {|n| n.last_name}.first(10)
    @junior_standings = IndivStanding.for_juniors(7)
    @senior_standings = IndivStanding.for_seniors(7)
    @seniorb_standings = IndivStanding.for_seniorb(7)
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @student_division = @student.current_team.division
    @student_standing = IndivStanding.for_indiv(@student)
    @quiz_year = QuizYear.new
    @year_quizzer = YearQuizzer.new(@student)
    @top_standings = IndivStanding.for_juniors(3)
    @year_quizzes = YearQuizzer.find_scored_events_for_year(@quiz_year).map
    @x_axis = @year_quizzes.map {|e| e.start_date.strftime('%b')} #x-values
    @events = @year_quizzes.map{ |e| EventQuizzer.new(@student, e)}
    @performance = @events.map{|p| p.total_points}
    @top_student = IndivStanding.find_top_student(@student).first.student
    #@top_scores = EventQuizzer.get_top_score(@student_division)
    #@average_scores = EventQuizzer.get_average_score(@student_division)
    @top_four = IndivStanding.show_top_four(@student)
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => "Performance")
      f.xAxis(:categories => @x_axis)
      f.series(:name => "Top Student Performance", :color => "#c3dadd" , :data => @top_scores)
      f.series(:name => @student.first_name + " Performance", :color => "#00bcd4", :data => @performance)
      #f.series(:name => "Average Performance", :data => @average_scores)
      f.yAxis [
        {:title => {:text => "Quiz Scores", :margin => 70}, :min => 0, :max => 540 }
      ]
      f.chart({:defaultSeriesType=>"line"})
    end 

    # @win_chart = LazyHighCharts::HighChart.new('graph') do |f|
    #   f.xAxis(:categories => @x_axis)
    #   f.series(:name => @student.first_name + " First Place Wins", :color => "#00bcd4", :data => @performance)
    #   f.yAxis [
    #     {:title => {:text => "Wins", :margin => 70}, :min => 0, :max => 540 }
    #   ]
    #   f.chart({:defaultSeriesType=>"column"})
    # end 
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
      #@collection = @student.current_organization.teams.active.alphabetical
      @collection = Team.not_at_capacity(@student, @student.current_organization)
      @team_id = -1
    else
      @student_team = @student.current_student_team
      #@collection = @student.current_organization.teams.active.alphabetical.for_division(@student.current_team.division)
      @collection = Team.not_at_capacity(@student, @student.current_organization, @student.current_team.division)
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
        @student.add_to_organization(current_user)
        format.html { redirect_to @student, notice: "#{@student.name} has been created." }
        #format.json { render action: 'show', status: :created, location: @student }
        @active_teams = Team.all.active
        @divisions = Division.all.active
        format.js
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
    @divisions = Division.all.active
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
