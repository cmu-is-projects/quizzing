class CoachesController < ApplicationController
  before_action :set_coach, only: [:show, :edit, :update, :destroy]
  before_action :verify_user_is_area_admin, :only => [:new, :create, :edit, :update, :destroy]

  # GET /coaches
  # GET /coaches.json
  def index
    @coaches = Coach.all
  end

  # GET /coaches/1
  # GET /coaches/1.json
  def show
  end

  # GET /coaches/new
  def new
    if(!logged_in?)
      redirect_to login_url and return
    end
    @coach = Coach.new
  end

  # GET /coaches/1/edit
  def edit
    if(!logged_in?)
      redirect_to login_url and return
    end
  end

  # POST /coaches
  # POST /coaches.json
  def create
    if(!logged_in?)
      redirect_to login_url and return
    end
    @coach = Coach.new(coach_params)

    respond_to do |format|
      if @coach.save
        format.html { redirect_to @coach, notice: 'Coach was successfully created.' }
        format.json { render action: 'show', status: :created, location: @coach }
      else
        format.html { render action: 'new' }
        format.json { render json: @coach.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coaches/1
  # PATCH/PUT /coaches/1.json
  def update
    if(!logged_in?)
      redirect_to login_url and return
    end
    respond_to do |format|
      if @coach.update(coach_params)
        format.html { redirect_to @coach, notice: 'Coach was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @coach.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coaches/1
  # DELETE /coaches/1.json
  def destroy
    if(!logged_in?)
      redirect_to login_url and return
    end
    @coach.destroy
    respond_to do |format|
      format.html { redirect_to coaches_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coach
    if(!current_user.role?(:admin))
      redirect_to login_url and return
    end
      @coach = Coach.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coach_params
      params.require(:coach).permit(:first_name, :last_name, :phone, :email, :active)
    end
end
