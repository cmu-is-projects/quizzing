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

  def coach
    NullCoach.new
  end
end
