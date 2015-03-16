class NullUser
  def user_name
    "N/A"
  end

  def role
    "guest"
  end

  def active
    false
  end

  def coach
    NullCoach.new
  end
end