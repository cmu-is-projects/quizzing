class EventTeam
  def initialize(team, event)
    @team = team
    @name = team.name
    @event = event
    @students = team.students
    @quiz_teams = get_all_quiz_teams_for_team_in_this_event
  end

  attr_reader :event, :team, :students, :name, :quiz_teams

  def total_points
    #Top down; go to QuizTeam
    quiz_teams.inject(0){|sum, quiz_team| sum += quiz_team.raw_score}
  end
  
  def get_all_quiz_teams_for_team_in_this_event
    quiz_teams = QuizTeam.for_team(team).for_event(event).by_round_num.to_a
  end
end #class EventTeam