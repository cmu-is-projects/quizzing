class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_user_name(params[:user_name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      set_session_event #inherited from application_controller
      #TODO1:
      #session[:first_name] = user.first_name
      #session[:organization_id]
        #if no current_organization, set it to negative one
        # else set a session variable to their church
      #TODO1:
      #event_id
      #TODO:
      # switch churches methods (changes session variable to that church id)
      @u_coach = Coach.where(user_id: user.id).first
      if @u_coach.nil?
        session[:organization_id] = -1
      else
        session[:organization_id] = @u_coach.organization_id
      end
      session[:user_name] = user.user_name
      redirect_to home_path, notice: "Logged in!"
    else
      flash.now.alert = "Username or password is invalid"
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to home_path, notice: "Logged out!"
  end
end
