class NullIndivStanding
  def position
    1
  end

  def student
    NullStudent.new
  end

  def team
    NullTeam.new
  end

  def division_id
    NullDivision.new.id
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