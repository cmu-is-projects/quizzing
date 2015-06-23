module SessionManager
  def adjust_auth_attempts_count
    if session[:auth_attempts].nil?
      session[:auth_attempts] = 1
    else  
      session[:auth_attempts] += 1
    end
  end

  def set_session_event
    # Documentation: Assumed to be the quiz for today's date or the next one
    e = Event.where("start_date >= ? or (start_date = ? and end_date = ?)", Date.today,Date.yesterday,Date.today).order(:start_date).first
    if e
      session[:event_id] = e.id
    else
      session[:event_id] = nil
    end
    
  end

  def set_organization_id(user)
    user_coach = Coach.where(user_id: user.id).first
    if user_coach.nil?
      session[:organization_id] = -1
    else
      session[:organization_id] = user_coach.organization_id
    end
  end

  def set_session_vars_after_login(user)
    session[:user_id] = user.id
    session[:username] = user.username
    session[:first_name] = user.coach.first_name unless user.coach.nil?
    session[:last_name] = user.coach.last_name unless user.coach.nil?
    session[:role] = user.role  
    session[:auth_attempts] = nil 
    set_session_event 
    set_organization_id(user)
  end

  def user_changed_settings?(user)
    return true if user.is_coach?
    setting = Setting.first
    status = true
    status = false if setting.area_name == 'YOUR AREA NAME HERE'
    status = false if setting.admin_name == 'YOUR NAME HERE'
    status = false if setting.admin_email == 'asdf@example.com'
    status = false if setting.intro == 'Please update your info'
    return status
  end

  def send_to_landing_page(subdomain=nil)
    # if subdomain.nil?
    #   redirect_to overall_home_path, notice: "Logged in!"
    # else
      redirect_to home_path, notice: "Logged in!"
    # end  
  end

  def clear_session_data
    session[:user_id] = nil
    session[:username] = nil
    session[:first_name] = nil
    session[:last_name] = nil
    session[:role] = nil
    session[:event_id] = nil
    session[:organization_id] = nil
  end
end