class EventQuizzer
  def initialize(quizzer, event)
    @event = event
    @quizzer = quizzer
    @name = quizzer.proper_name
    @event_name = event.name
    @team_name = quizzer.current_team.name
  end

  attr_reader :event, :quizzer
  attr_reader :name, :event_name, :team_name

  def total_points
    # calculate the total points for this quizzer in this event
  end

  def average_points
    # calculate the average points per round for this quizzer in this event
  end

  def accuracy
    # calculate the accuracy rate for this quizzer in this event
  end
  
  
end