class YearTeam
  
  def initialize(team, quiz_year=QuizYear.new)
    @year = quiz_year
    @team = team
    @result = get_results_for_each_quiz_this_year
    @name = @team.name
    @division = @team.division
  end

  # The other file has attr_reader stuff here. What is it?

  # What's the inject stuff in the other file? What does this return, if 
  # anything?
  def total_points
    int total = 0
    QuizTeam.all.where(team_id: @team.id).each do |qt|
      total += qt.points
    end
    return total
  end
  
  # Does team want an equivalent lower_points method?

  # How is adjusted points any different?

  # Do teams have a total_accuracy?

  def self.get_all_teams_for_division_for_year(division, 
                                               quiz_year=QuizYear.new)
    teams_this_year = self.get_all_teams_that_quizzed_in_year(quiz_year)
    teams = Array.new
    teams_this_year.each do |team_id|
      year_team = YearTeam.new(Team.find(|team_id|), quiz_year)
      teams << year_team if year_team.divsion == divison
    end
    # Do we want to be sorting by something else/?
    sorted = teams.sort_by(|yt| yt.adjusted_points}.reverse
  end

#############################################################################
private

end
