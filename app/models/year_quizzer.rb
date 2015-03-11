class YearQuizzer
  def initialize(quizzer, start_year=nil)
    @year = QuizYear.new(start_year)
    @quizzer = quizzer
    @name = quizzer.proper_name
    @team_name = quizzer.current_team.name
    @events = find_scored_events_for_this_year      # scored events that occurred this year
    @results = get_results_for_each_quiz_this_year  # i.e., event_quizzes for this year

  end

  attr_reader :quizzer, :year
  attr_reader :name, :team_name, :events, :results

  def total_points
    results.inject(0){|sum, event_quizzer| sum += event_quizzer.total_points}
  end

  def lowest_points
    results.map{|r| r.total_points}.sort!.reverse!.pop
  end

  def adjusted_points
    if results.size > 3
      results.map{|r| r.total_points}.sort!.reverse!.pop
      results.inject(0){|sum, event_quizzer| sum += event_quizzer.total_points}
    else
      self.total_points
    end
  end

  def total_accuracy
    total_correct = results.inject(0){|sum, evt_quiz| sum += evt_quiz.student_quizzes.map{|sq| sq.num_correct}.inject(0){|sum, correct| sum += correct} }
    total_attempts = results.inject(0){|sum, evt_quiz| sum += evt_quiz.student_quizzes.map{|sq| sq.num_attempts}.inject(0){|sum, attempts| sum += attempts} }
    if total_attempts.zero?
      acc_rate = 0.0
    else
      acc_rate = (total_correct.to_f / total_attempts).round(3)
    end
  end

  def self.get_all_quizzers_for_this_year #_for_division(division)
    students_this_year = Array.new
    events.each do |event|
      students_this_year << StudentQuiz.for_event(event).map(&:student_id).uniq
    end
    students_this_year = students_this_year.compact.uniq
    quizzers = Array.new
    students_this_year.each do |stu_id|
      year_quizzer = YearQuizzer.new(Student.find(stu_id), year.start_date.year)
      quizzers << year_quizzer
    end
    sorted = quizzers.sort_by{|yq| yq.adjusted_points}.reverse
  end


  private
  def find_scored_events_for_this_year
    if Date.today > year.end_date
      events = Event.where("start_date >= ? and end_date <= ?", year.start_date, year.end_date)
    else
      events = Event.where("start_date >= ? and end_date <= ?", year.start_date, Date.today)
    end
    events
  end

  def get_results_for_each_quiz_this_year
    event_quizzes = Array.new
    events.each do |event|
      event_quizzes << EventQuizzer.new(quizzer, event)
    end
    # sort chronologically by start_date
    sorted = event_quizzes.sort_by{|eq| eq.event.start_date}
  end
  
  
end