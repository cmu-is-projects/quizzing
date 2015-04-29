class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

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
    @quizzes = @event.quizzes
    #@teams = @event.quizzes.teams
  end

  # GET /events/new
  def new
    if(!logged_in?)
      redirect_to login_url and return
    end
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    if(!logged_in?)
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
    if(!logged_in?)
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
    if(!logged_in?)
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
    if(!logged_in?)
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      convert_start_and_end_dates
      params.require(:event).permit(:start_date, :end_date, :start_time, :num_rounds, :organization_id, quiz_attributes: [:id, :division_id, :round_num, :room_num])
    end
end
