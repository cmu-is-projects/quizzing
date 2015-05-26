class PostOffice < ActionMailer::Base
  default from: "profh@cmu.edu"

  def new_user_msg(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to biblequizstats.net")
  end

  def reset_password_msg(user)
    @user = user
    if Rails.env.development?
      @request = 'quizzing.dev'
    else
      @request = 'biblequizstats.net'
    end
    mail(:to => user.email, :subject => "Request to reset password at biblequizstats.net")
  end

end
