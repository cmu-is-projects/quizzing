class EventQuizzer
  def initialize(quizzer, event)
    @event = event
    @quizzer = quizzer
    @name = quizzer.proper_name
    @event_name = event.name
    @team_name = quizzer.current_team.name
    @student_quizzes = get_all_quizzes_for_student_in_this_event
  end

  attr_reader :event, :quizzer
  attr_reader :name, :event_name, :team_name
  attr_reader :student_quizzes

  def total_points
    # calculate the total points for this quizzer in this event
  end

  def average_points
    # calculate the average points per round for this quizzer in this event
  end

  def accuracy
    # calculate the accuracy rate for this quizzer in this event
  end

  def get_all_quizzes_for_student_in_this_event
    # gets student_quiz objects for a student during a particular event
    student_quizzes = StudentQuiz.for_student(quizzer).for_event(event)
  end
  
  
end