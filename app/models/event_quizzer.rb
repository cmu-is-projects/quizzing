class EventQuizzer
  def initialize(quizzer, event)
    @event = event
    @quizzer = quizzer
    @name = quizzer.proper_name
    @event_name = event.organization.name
    @team_name = quizzer.current_team.name
    @student_quizzes = get_all_quizzes_for_student_in_this_event
  end

  attr_reader :event, :quizzer
  attr_reader :name, :event_name, :team_name
  attr_reader :student_quizzes

  def total_points
    student_quizzes.inject(0){|sum, quiz| sum += quiz.score}
  end

  def average_points
    (total_points.to_f / student_quizzes.size).round(2)
  end

  def accuracy
    total_correct = student_quizzes.inject(0){|sum, quiz| sum += quiz.num_correct}
    total_attempts = student_quizzes.inject(0){|sum, quiz| sum += quiz.num_attempts}
    acc_rate = (total_correct.to_f / total_attempts).round(3)
  end

  def get_all_quizzes_for_student_in_this_event
    # gets student_quiz objects for a student during a particular event
    student_quizzes = StudentQuiz.for_student(quizzer).for_event(event)
  end
  
  
end