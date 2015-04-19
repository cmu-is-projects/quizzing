class EventTeam
  def initialize(team, event)
    @team = team
    @name = team.name
    @event = event
    @students = team.students
  end

  attr_reader :event, :team, :students, :name

end #class EventTeam