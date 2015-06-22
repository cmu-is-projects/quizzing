class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :schedule]

  # GET /events
  # GET /events.json
  def index
    # all upcoming events
    @upcoming_events = Event.upcoming.chronological.to_a

    # all events for this quiz year
    @quiz_year = QuizYear.new
    @events = @quiz_year.this_yr_events

    # events that happened in previous quiz years
    @past_events = @quiz_year.prev_events
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @quizzes = @event.quizzes.sort{|a,b| a.round_num <=> b.round_num}
    @divisions = Division.all.active
    @juniors = Division.find_by_name("juniors")
    @senior_a = Division.find_by_name("seniors")
    @senior_b = Division.find_by_name("seniorb")
    @total_room_num = Quiz.maximum(:room_num)
    @senior_a_round_num = Quiz.for_division(@senior_a).maximum(:round_num)
    @senior_b_round_num = Quiz.for_division(@senior_b).maximum(:round_num)
    @junior_round_num = Quiz.for_division(@juniors).maximum(:round_num)
    @matrix = Quiz.find_by_event_id_and_room_num_and_round_num(@event.id,@total_room_num,@round_num)

  end

  def schedule
    #@team = Team.find(params[:team_id])
    #@team = Team.find_by(id: team_params[:id])
    #@team = Team.find_by(id: params[:team_id])
    @total_round_num = @event.quizzes.map{|q| q.round_num}.max
    @team = Team.all.to_a[32] #NEEDS TO BE THROUGH A FORM
    @division1 = @team.division
    @junior_teams = Team.all.where(division_id: 1)
    #@division2 = Division.all.to_a[1]
    #@division3 = Division.all.to_a[2]
    #@junior_matrix = MatrixGenerator.get_matrix_for_event_and_division(@event, @division1)
    #@senior_matrix = MatrixGenerator.get_matrix_for_event_and_division(@event, @division2)
    #@seniorb_matrix = MatrixGenerator.get_matrix_for_event_and_division(@event, @division3)
    @matrix = MatrixGenerator.get_matrix_for_event_and_division(@event, @division1)
  end

  # GET /events/new
  def new
    if(!current_user.role?(:admin))
      redirect_to login_url and return
    end
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    if(!current_user.role?(:admin))
      redirect_to login_url and return
    end
    @event_teams = Team.all
    @divisions = Division.all
    # @senior_a_teams = Team.all.for_division(@senior_a)
    @event.start_date = humanize_date @event.start_date
    @event.end_date = humanize_date @event.end_date
  end

  # POST /events
  # POST /events.json
  def create
    if(!current_user.role?(:admin))
      redirect_to login_url and return
    end
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    if(!current_user.role?(:admin))
      redirect_to login_url and return
    end
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    if(!current_user.role?(:admin))
      redirect_to login_url and return
    end
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def convert_start_and_end_dates
      params[:event][:start_date] = convert_to_date(params[:event][:start_date]) unless params[:event][:start_date].blank?
      params[:event][:end_date] = convert_to_date(params[:event][:end_date]) unless params[:event][:end_date].blank?
    end

    #Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      convert_start_and_end_dates
      params.require(:event).permit(:start_date, :end_date, :start_time, :num_rounds, :organization_id, quiz_attributes: [:id, :event_id, :division_id, :category_id, :round_num, :room_num, :active])
    end
end
