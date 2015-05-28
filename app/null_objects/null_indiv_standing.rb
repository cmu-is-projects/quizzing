class NullIndivStanding
  def position
    1
  end

  def student_id
    null_student.new.id
  end

  def team_id
    null_team.new.id
  end

  def division_id
    null_division.new.id
  end

  def total_points
    123
  end

  def lowest_score
    40
  end

  def adjusted_points
    115
  end

  def accuracy
    0.85
  end
end