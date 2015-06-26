class PasswordResetsController < ApplicationController
  include SessionManager

  def new
  end

  def create
    password_reset = PasswordManager.from_email(params[:email])
    if password_reset.user
      password_reset.send_email(session[:subdomain])
      redirect_to cmuis_home_path, notice: "Email sent with password reset instructions."
    else
      flash[:error] = "This email is not registered in the system."
      redirect_to login_path 
    end
  end

  def edit
    password_reset = PasswordManager.from_token(params[:id])
    @user = password_reset.user
  end

  def update
    password_reset = PasswordManager.from_token(params[:id])
    @user = password_reset.user
    if password_reset.expired?
      msg = (@user.token_type == 'new' ? 'new password' : 'password reset')
      redirect_to login_path, alert: "Your #{msg} token has expired. Please reset your password again."
    elsif @user.update_attributes(reset_params)
      # log the user into system after updating
      set_session_vars_after_login(@user)
      current_user
      # send to home with notice
      redirect_to home_path, notice: "Your password has been changed and you are now logged into the system."
    else
      render :edit
    end
  end

  def reset_params
    params.require(:user).permit(:password, :password_confirmation)  
  end
end