class EventTeam
  def initialize(team, event)
    @team = team
    @name = team.name
    @event = event
    @students = team.students
  end

  attr_reader :event, :team, :students, :name
  
  def get_all_team_quizzes_for_team_in_this_event
  #TODO: test by_round_num
    team_quizzes = StudentTeam.for_team(team).for_event(event).by_round_num.to_a
  end
end #class EventTeam