module ExceptionManager
  def no_database_exists
    flash[:error] = "The district or area you are looking for is not currently available."
    redirect_to root_url(:host => request.domain)
  end

  def no_connection_established
    flash[:error] = "The database is currently unavailable. Please contact the overall administrator for assistance."
    redirect_to root_url(:host => request.domain)
  end

  def no_reset_token
    flash[:error] = "The password reset token is either invalid or has expired."
    redirect_to home_path
  end

  # Rescue from timed out user
  def user_timed_out
    flash[:error] = "This user's account has been timed out. Please try again in a few hours."
    redirect_to home_path
  end

  # Rescue from attempted hammering
  def stop_hammering
    flash[:error] = "Too many login attempts. This user's account has been timed out. Please try again in an hour."
    redirect_to home_path
  end
end