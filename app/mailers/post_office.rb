class PostOffice < ActionMailer::Base
  default from: "#{Setting.first.admin_email}"

  def new_coach_msg(user, subdomain)
    setup_for_mailer(user, subdomain)
    mail(:to => user.email, :subject => "Welcome to biblequizstats.net")
  end

  def new_admin_msg(user, subdomain)
    setup_for_mailer(user, subdomain)
    mail(:to => user.email, :subject => "Welcome to biblequizstats.net")
  end

  def reset_password_msg(user, subdomain)
    setup_for_mailer(user, subdomain)
    mail(:to => user.email, :subject => "Request to reset password at biblequizstats.net")
  end

  def setup_for_mailer(user, subdomain)
    @user = user
    @setting = Setting.first
    if Rails.env.development?
      @request = "#{subdomain}.quizzing.dev"
    else
      @request = "#{subdomain}.biblequizstats.net"
    end
  end

end
