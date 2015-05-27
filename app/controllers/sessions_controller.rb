class SessionsController < ApplicationController
  include AuthSecurity
  include SessionManager

  def new
  end

  def create
    # count the number of authentication attempts
    adjust_auth_attempts_count

    # find the user by username
    user = User.find_by_username(params[:username])

    if user
      # assuming the username matches a user in the system...
      verify_user_not_timed_out(user)
      verify_account_not_being_hammered(user, session[:auth_attempts])

      # make sure the user has the right password        
      if user.authenticate(params[:password])
        set_session_vars_after_login(user)
        # connect_to_db(session[:subdomain])
        current_user
        send_to_landing_page(session[:subdomain])
      else
        handle_failed_attempt
      end
    else
      handle_failed_attempt
    end
  end
  
  def destroy
    clear_session_data
    redirect_to home_path, notice: "Logged out!"
  end

  private
  def handle_failed_attempt
    flash.now.alert = "Username or password is invalid"
    render "new"
  end
end
