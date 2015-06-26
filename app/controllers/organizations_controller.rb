class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  before_action :verify_user_is_area_admin, :only => [:new, :create, :edit, :update, :destroy]


  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = Organization.all
    
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
    @organization_active_students = @organization.students.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @organization_inactive_students = @organization.students.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
    @divisions = Division.all.alphabetical
    @organization_teams = @organization.teams
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
    @coach = Coach.new
    user = @coach.build_user
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)

    respond_to do |format|
      if @organization.save
        save_coach_for_organization
        format.html { redirect_to settings_path, notice: "#{@organization.name} was created" }
        format.json { render action: 'show', status: :created, location: @organization }
      else
        format.html { render action: 'new' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url }
      format.json { head :no_content }
    end
  end

  def toggle_organization
    @organization = Organization.find(params[:id])
    @organization.active = params[:active] unless params[:active].nil?
    @organization.save!
    @organizations = Organization.alphabetical.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name, :short_name, :street_1, :street_2, :city, :state, :zip, :latitutde, :longitude, :active, :coach_ids => [])
      # params.require(:coach).permit(:first_name, :last_name, :phone, :active, :user_attributes => [:username, :email])
    end

      def setup_coach_for_organization
        @coach = Coach.new
        @coach.first_name = params[:coach][:first_name] unless params[:coach][:first_name].nil?
        @coach.last_name = params[:coach][:last_name] unless params[:coach][:last_name].nil?
        @coach.phone = params[:coach][:phone] unless params[:coach][:phone].nil?
        @coach.active = true
        @coach.save!

        @coach.user = User.new
        @coach.user.username = params[:coach][:user_attributes][:username]
        @coach.user.email = params[:coach][:user_attributes][:email]
        @coach.user.role = "coach"
        @coach.user.password = SETTINGS[:default_password]
        @coach.user.password_confirmation = SETTINGS[:default_password]
        @coach.user.active_after = Time.now
        @coach.user.active = true
        @coach.user.save!
        @coach.update_attribute(:user_id, @coach.user.id)
        @organization.update_attribute(:primary_contact_id, @coach.id)
    end
end
