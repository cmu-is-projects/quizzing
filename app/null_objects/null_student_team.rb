class NullStudentTeam
  def active
    false
  end

  def students
    [NullStudent.new]
  end

  def teams
    [NullTeam.new]
  end

  def is_captain
    false
  end

  def start_date
    Date.today
  end

  def end_date
    Date.today
  end

end