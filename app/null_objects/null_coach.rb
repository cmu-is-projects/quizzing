class NullCoach
  def first_name
    "Unknown"
  end

  def last_name
    "Coach"
  end

  def phone
    "N/A"
  end

  def email
    "N/A"
  end

  def active
    false
  end
    
  def user
    NullUser.new
  end

  def organization
    NullOrganization.new
  end

  def teams
    [NullTeam.new]
  end

  def name
    return "Coach, Unknown"
  end

  def proper_name
    return "Unknown Coach"
  end
end
 