class ApplicationController < ActionController::Base
  include ExceptionManager
  include DatabaseSwitcher
  
  # check which database to use...
  before_action :determine_correct_database #if Rails.env.production?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # TODO: handle missing pages... 
  rescue_from ActiveRecord::RecordNotFound do |exception|
    # render template: 'errors/not_found'
    redirect_to home_path, error: "Record not found in the system."
  end

  rescue_from AbstractController::ActionNotFound do |exception|
    render template: 'errors/not_found'
  end

  # Rescue from custom exceptions
  rescue_from Exceptions::NoDatabaseExists, with: :no_database_exists
  rescue_from Exceptions::NoPasswordResetToken, with: :no_reset_token
  rescue_from Exceptions::UserIsTimedOut, with: :user_timed_out
  rescue_from Exceptions::AttemptedHammering, with: :stop_hammering

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
    redirect_to login_path, alert: "You need to log in as a coach or adminstrator to view this page." if current_user.nil? || current_user.is_guest?
  end

  def verify_user_is_admin
    redirect_to home_path, alert: "You need to be a system administrator to access this page." unless current_user.is_admin?
  end

  def verify_user_is_area_admin
    redirect_to home_path, alert: "You need to be an area administrator to access this page." unless current_user.is_area_admin? || current_user.is_admin?
  end

  def verify_user_is_coach
    redirect_to home_path, alert: "You need to be a coach to access this page." unless current_user.is_coach?
  end

end
