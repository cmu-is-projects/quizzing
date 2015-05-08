class NullTeam
  def name
    "N/A"
  end

  def active
    false
  end

  def inactive
    true
  end

  def division
    NullDivision.new
  end

  def organization
    NullOrganization.new
  end

  def students
    [NullStudent.new]
  end

  def quizzes
    [NullQuiz.new]
  end

  def coaches
    [NullCoach.new]
  end

  def current_students
    [NullStudent.new]
  end
end