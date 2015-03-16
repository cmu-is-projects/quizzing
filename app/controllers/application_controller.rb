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

end
