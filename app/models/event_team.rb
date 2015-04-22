class EventTeam
  def initialize(team, event)
    @team = team
    @name = team.name
    @event = event
    @students = team.students
    @team_quizzes = get_all_team_quizzes_for_team_in_this_event
  end

  attr_reader :event, :team, :students, :name, :team_quizzes

  def total_team_points
    team_quizzes.inject(0){|sum, quiz| sum += quiz.team_score}
  end
  
  def get_all_team_quizzes_for_team_in_this_event
    team_quizzes = QuizTeam.for_team(team).for_event(event).by_round_num.to_a
  end
end #class EventTeam