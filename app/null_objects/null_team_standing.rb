class NullTeamStanding
  def position
    1
  end

  def team
    NullTeam.new
  end

  def division
    NullDivision.new
  end

  def total_points
    0
  end

  def accuracy
    0.85
  end
end