ActionMailer::Base.smtp_settings = {  
  :address              => SETTINGS[:mailer_service],  
  :port                 => 587,  
  :user_name            => SETTINGS[:mailer_user],  
  :password             => SETTINGS[:mailer_password],  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}