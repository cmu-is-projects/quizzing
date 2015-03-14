class NullDivision
  def name
    "N/A"
  end

  def start_grade
    0
  end

  def end_grade
    0
  end

  def active
    false
  end

  def teams
    [NullTeam.new]
  end

  def quizzes
    [NullQuiz.new]
  end
end
