#written based on YearQuizzer
#TODO: test this whole thing; do not use until tested
class YearTeam
  def initialize(team, quiz_year=QuizYear.new)
    @year = quiz_year
    @team = team
    @name = team.name
    @results = get_results_for_each_quiz_this_year # i.e., event_teams for this year
    @division = team.division
  end

 attr_reader :team, :year
 attr_reader :name, :results
 attr_reader :division

 # # What's the inject stuff in the other file? What does this return, if 
 #  # anything?
 #  def total_points
 #    int total = 0
 #    QuizTeam.all.where(team_id: @team.id).each do |qt|
 #      total += qt.points
 #    end
 #    return total
 #  end
  
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
  
  def ytd_score
 	#top down design assuming event_team written with a total_points method
 	self.results.inject(0){|sum, event_team| sum += event_team.total_points}
  end

  def get_all_teams
  	#top down design assuming "get_all_teams_who_quizzed_in_year" written
    teams_this_year = self.get_all_teams_who_quizzed_in_year(quiz_year=QuizYear.new, quiz_year)
    teams = Array.new
    teams_this_year.each do |team_id|
      year_team = YearTeam.new(Team.find(team_id), quiz_year)
      teams << year_team
    end
    sorted = teams.sort_by{|yt| yt.ytd_score}.reverse	
  end

  private
  def self.get_all_teams_who_quizzed_in_year(quiz_year)
    tmp = Array.new
    #top down design assuming self.find_scored_events_for_year(quiz_year) working
    events = self.find_scored_events_for_year(quiz_year)
    events.each do |event|
      tmp << QuizTeam.for_event(event).map(&:team_id).uniq
    end
    teams_this_year = tmp.flatten.compact.uniq
  end

  def self.find_scored_events_for_year(quiz_year)
    if Date.today > quiz_year.end_date
      events = Event.where("start_date >= ? and end_date <= ?", quiz_year.start_date, quiz_year.end_date)
    else
      events = Event.where("start_date >= ? and end_date <= ?", quiz_year.start_date, Date.today)
    end
    events
  end

  # The other file has attr_reader stuff here. What is it?

  

end
