class NullStudent
  def first_name
    "Unknown"
  end

  def last_name
    "Student"
  end

  def grade
    0
  end

  def active
    false
  end

  def inactive
    true
  end

  def teams
    [NullTeam.new]
  end

  def organizations
    [NullOrganization.new]
  end

  def quizzes
    [NullQuiz.new]
  end

  def name
    return "Student, Unknown"
  end

  def proper_name
    return "Unknown Student"
  end

  def current_organization
    NullOrganization.new
  end

  def current_team
    NullTeam.new
  end

end
