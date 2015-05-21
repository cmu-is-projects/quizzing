class NullUser
  def user_name
    "N/A"
  end

  def role
    "guest"
  end

  def role?(authorized_role)
    return role == authorized_role
  end

  def active
    false
  end

  def inactive
    true    
  end
  
  def coach
    NullCoach.new
  end

  def humanize_role
    "Guest"
  end

  def is_admin?
    false
  end

  def is_area_admin?
    false
  end

  def is_coach?
    false
  end
end
