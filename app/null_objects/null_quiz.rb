class NullQuiz
  def division
    NullDivision.new
  end

  def event
    NullEvent.new
  end

  def room_num
    0
  end

  def round_num
    0
  end

  def active
    false
  end

  def students
    [NullStudent.new]
  end

  def teams
    [NullTeam.new]
  end

end
