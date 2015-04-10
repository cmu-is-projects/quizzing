class EventQuizzer
  def initialize(quizzer, event)
    @event = event
    @quizzer = quizzer
    @team = get_team_for_event
    @division = team.division
    @name = quizzer.proper_name
    @event_host = event.organization.name
    #TODO: order by_round_num
    @student_quizzes = get_all_student_quizzes_for_student_in_this_event(@quizzer, @event)
  end

  attr_reader :event, :quizzer, :team, :division
  attr_reader :name, :event_host
  attr_reader :student_quizzes

  def total_points
    student_quizzes.inject(0){|sum, quiz| sum += quiz.score}
  end

  def average_points
    # round points to 2 decimal places
    if student_quizzes.empty?
      avg_pts = 0.0
    else
      avg_pts = (total_points.to_f / student_quizzes.size).round(2)
    end
  end

  def accuracy
    # round accuracy to 3 decimal places
    total_correct = student_quizzes.inject(0){|sum, quiz| sum += quiz.num_correct}
    total_attempts = student_quizzes.inject(0){|sum, quiz| sum += quiz.num_attempts}
    if total_attempts.zero?
      acc_rate = 0.0
    else
      acc_rate = (total_correct.to_f / total_attempts).round(3)
    end
  end

  #I (Theophilus) had to append the parameters to the method name
  def get_all_student_quizzes_for_student_in_this_event(quizzer, event)
    # gets student_quiz objects for a student during a particular event
    student_quizzes = StudentQuiz.for_student(quizzer).for_event(event).by_round_num.to_a
  end

  def self.get_all_quizzers_for_event(event)
    all_student_at_event = StudentQuiz.for_event(event).map(&:student_id).uniq
    quizzers = Array.new
    all_student_at_event.each do |stu_id|
      event_quizzer = EventQuizzer.new(Student.find(stu_id), event)
      quizzers << event_quizzer
    end
    # returned a sorted array of event_quizzers in descending order of average points
    # (until end when avg and total align, averages rule the day in reporting results)
    sorted = quizzers.sort_by{|eq| eq.average_points}.reverse
  end

  def self.get_all_quizzers_for_event_and_division(event, division)
    event_quizzers = EventQuizzer.get_all_quizzers_for_event(event)
    in_division = Array.new
    event_quizzers.each do |event_quizzer|
      in_division << event_quizzer if event_quizzer.division == division
    end
    # resort just to be safe...
    final = in_division.sort_by{|eq| eq.average_points}.reverse 
  end

  private
  def get_team_for_event
    if quizzer.student_teams.empty? || quizzer.student_teams.for_date(event.start_date).empty?
      NullTeam.new
    else
      quizzer.student_teams.for_date(event.start_date).first.team
    end
  end
  
end