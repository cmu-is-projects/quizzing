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

  def teams
    [NullTeam.new]
  end

  def organizations
    [NullOrganization.new]
  end

  def quizzes
    [NullQuiz.new]
  end

end
