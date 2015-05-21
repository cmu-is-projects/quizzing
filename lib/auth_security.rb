module AuthSecurity
  def verify_user_not_timed_out(user)
    if user.active_after > Time.now
      # if user already timed out, add 30 minutes and raise exception
      user.active_after = 30.minutes.from_now
      user.save
      raise Exceptions::UserIsTimedOut
    end
  end

  def verify_account_not_being_hammered(user, attempts)
    if attempts > 5
      # if user has exceeded number of attempts, time out and raise exception
      user.active_after = 1.hour.from_now
      user.save
      session[:auth_attempts] = nil # reset the count b/c user is timed out
      raise Exceptions::AttemptedHammering 
    end
  end
end