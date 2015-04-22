class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_user_name(params[:user_name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      #TODO1:
      #session[:first_name] = user.first_name
      #session[:organization_id]
        #if no current_organization, set it to negative one
        # else set a session variable to their church
      #TODO1:
      #event_id
      #TODO:
      # switch churches methods (changes session variable to that church id)
      @u_coach = Coach.all.where(user_id: user.id)
      session[:organization_id] = @u_coach.nil? || @u_coach.blank? ? -1 : @u_coach.first.organization_id
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
