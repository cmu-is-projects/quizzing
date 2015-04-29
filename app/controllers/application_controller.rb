class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  ### Handling various exceptions
  ### ---------------------------

  # TODO: handle missing pages... 
  # rescue_from ActiveRecord::RecordNotFound do |exception|
  #   render template: 'errors/not_found'
  # end

  # rescue_from AbstractController::ActionNotFound do |exception|
  #   render template: 'errors/not_found'
  # end

  # # Rescue from no database error
  # rescue_from Exceptions::NoDatabaseExists do |exception|
  #   flash[:error] = "The district or area you are looking for is not currently available."
  #   redirect_to root_url(:host => request.domain)
  # end

  # # Rescue from bad password reset token
  # rescue_from Exceptions::NoPasswordResetToken do |exception|
  #   flash[:error] = "The password reset token is either invalid or has expired."
  #   redirect_to root_url(:host => request.domain)
  # end

  # # Rescue from timed out user
  # rescue_from Exceptions::UserIsTimedOut do |exception|
  #   flash[:error] = "This user's account has been timed out. Please try again in a few hours."
  #   redirect_to root_url(:host => request.domain)
  # end

  # # Rescue from timed out user
  # rescue_from Exceptions::AttemptedHammering do |exception|
  #   flash[:error] = "Too many login attempts. This user's account has been timed out. Please try again in an hour."
  #   redirect_to root_url(:host => request.domain)
  # end

  # Just show a flash message instead of full CanCan exception
  # rescue_from CanCan::AccessDenied do |exception|
  #   flash[:error] = "You are not authorized to take this action.  Go away or I shall taunt you a second time."
  #   redirect_to home_path
  # end
  
  # rescue_from ActiveRecord::RecordNotFound do |exception|
  #   redirect_to home_path, error: "Record not found in the system."
  # end
  
  
  private
  # Handling authentication
  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      @current_user = NullUser.new
    end
  end
  helper_method :current_user
  
  def logged_in?
    current_user.role != "guest"
  end
  helper_method :logged_in?
  
  def check_login
    redirect_to login_url, alert: "You need to log in to view this page." if current_user.nil?
  end

end
