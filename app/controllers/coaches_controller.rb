class CoachesController < ApplicationController
  before_action :set_coach, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  # before_action :verify_user_is_area_admin, only: [:new, :create, :edit, :update, :destroy]

  def index
    if current_user.coach.nil?
      @coach = Coach.first
    else
      @coach = current_user.coach
    end
    # @coach = current_user.coach
    @junior_teams = Team.for_juniors(1000, @coach.organization)
    @senior_teams = Team.for_seniors(1000, @coach.organization)
    @seniorb_teams = Team.for_seniorb(1000, @coach.organization)
    @coaches = Coach.alphabetical.active.all
    @top_juniors = IndivStanding.for_juniors(10, @coach.organization)
    @top_seniors = IndivStanding.for_seniors(10, @coach.organization)
    @top_seniorb = IndivStanding.for_seniorb(10, @coach.organization)
    @improved_juniors = ResultCalculator.find_most_improved(@coach.organization, Division.find_by_name("juniors"))
    @improved_seniors = ResultCalculator.find_most_improved(@coach.organization, Division.find_by_name("seniors"))
    @improved_seniorb = ResultCalculator.find_most_improved(@coach.organization, Division.find_by_name("seniorb"))
  end

  def show
  end

  def new
    @coach = Coach.new
    user = @coach.build_user
  end

  def edit
  end

  def create
    @coach = Coach.new(coach_params)
    # reset organization_id if creator is a coach
    if current_user.role?(:coach)
      @coach.organization_id = current_user.coach.organization.id
    end
    setup_coach_user # setup a user for this coach given params, etc.
    if @coach.save
      @coach.user.save
      password_reset = PasswordManager.new(@coach.user)
      password_reset.for_new_user(session[:subdomain])
      redirect_to @coach, notice: "#{@coach.proper_name} was added as a coach."
    else
      render action: 'new'
    end
  end

  def update
    if @coach.update(coach_params)
      redirect_to @coach, notice: "#{@coach.proper_name} was edited in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @coach.destroy
    redirect_to coaches_url
  end

  private
    def set_coach
      @coach = Coach.find(params[:id])
    end

    def coach_params
      params.require(:coach).permit(:first_name, :last_name, :phone, :organization_id, :active, user_attributes: [:id, :username, :email, :_destroy])
    end

    def setup_coach_user
      @coach.user = User.new
      @coach.user.username = params[:coach][:user_attributes][:username]
      @coach.user.email = params[:coach][:user_attributes][:email]
      @coach.user.role = "coach"
      @coach.user.password = SETTINGS[:default_password]
      @coach.user.password_confirmation = SETTINGS[:default_password]
      @coach.user.active_after = Time.now
      @coach.user.active = true
    end
end
