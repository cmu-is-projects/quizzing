module ExceptionManager
  def no_database_exists
    logger.info("Rescue from Exceptions::NoDatabaseExists")
    flash[:alert] = "The district or area you are looking for is not currently available."
    logger.info("#{flash.map{|k,v| [k,v]}}")
    redirect_to root_url(:host => request.domain) #, alert: "The district or area you are looking for is not currently available."
  end

  def no_connection_established
    logger.info("Rescue from Exceptions::ConnectionNotEstablished")
    flash[:error] = "The database is currently unavailable. Please contact the overall administrator for assistance."
    redirect_to root_url(:host => request.domain)
  end

  def no_reset_token
    logger.info("Rescue from Exceptions::NoPasswordResetToken")
    flash[:error] = "The password reset token is either invalid or has expired."
    redirect_to home_path
  end

  # Rescue from timed out user
  def user_timed_out
    logger.info("Rescue from Exceptions::UserIsTimedOut")
    flash[:error] = "This user's account has been timed out. Please try again in a few hours."
    redirect_to home_path
  end

  # Rescue from attempted hammering
  def stop_hammering
    logger.info("Rescue from Exceptions::AttemptedHammering")
    flash[:error] = "Too many login attempts. This user's account has been timed out. Please try again in an hour."
    redirect_to home_path
  end
end