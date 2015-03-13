class YearQuizzer
  def initialize(quizzer, quiz_year=QuizYear.new)
    @year = quiz_year
    @quizzer = quizzer
    @name = quizzer.proper_name
    @results = get_results_for_each_quiz_this_year    # i.e., event_quizzes for this year
    @team = get_final_team_this_year
    @division = get_division_this_year
  end

  attr_reader :quizzer, :year
  attr_reader :name, :results, :team, :division

  def total_points
    results.inject(0){|sum, event_quizzer| sum += event_quizzer.total_points}
  end

  def lowest_points
    if results.size > 3
      tmp = results.clone
      lowest = tmp.map{|r| r.total_points}.sort!.reverse!.pop
      lowest ||= 0
    else
      lowest = '--'
    end
    lowest
  end

  def adjusted_points
    if results.size > 3
      adjusted = self.total_points - self.lowest_points
    else
      adjusted = self.total_points
    end
    adjusted
  end

  def total_accuracy
    total_correct = results.inject(0){|sum, evt_quiz| sum += evt_quiz.student_quizzes.map{|sq| sq.num_correct}.inject(0){|sum, correct| sum += correct} }
    total_attempts = results.inject(0){|sum, evt_quiz| sum += evt_quiz.student_quizzes.map{|sq| sq.num_attempts}.inject(0){|sum, attempts| sum += attempts} }
    if total_attempts.zero?
      accuracy_rate = 0.0
    else
      accuracy_rate = (total_correct.to_f / total_attempts).round(3)
    end
    accuracy_rate
  end

  # Class method to get all the year_quizzers for a particular year and division
  def self.get_all_quizzers_for_division_for_year(division, quiz_year=QuizYear.new)
    students_this_year = self.get_all_students_who_quizzed_in_year(quiz_year)
    quizzers = Array.new
    students_this_year.each do |stu_id|
      year_quizzer = YearQuizzer.new(Student.find(stu_id), quiz_year)
      quizzers << year_quizzer
    end
    refined_by_division = self.filter_out_results_for_division(quizzers, division)
    sorted = refined_by_division.sort_by{|yq| yq.adjusted_points}.reverse
  end

#################################
  # private
  def self.find_scored_events_for_year(quiz_year)
    if Date.today > quiz_year.end_date
      events = Event.where("start_date >= ? and end_date <= ?", quiz_year.start_date, quiz_year.end_date)
    else
      events = Event.where("start_date >= ? and end_date <= ?", quiz_year.start_date, Date.today)
    end
    events
  end

  def get_results_for_each_quiz_this_year
    event_quizzes = Array.new
    YearQuizzer.find_scored_events_for_year(year).each do |event|
      event_quizzes << EventQuizzer.new(quizzer, event)
    end
    # sort chronologically by start_date
    sorted = event_quizzes.sort_by{|eq| eq.event.start_date}
  end

  def self.get_all_students_who_quizzed_in_year(quiz_year)
    tmp = Array.new
    events = self.find_scored_events_for_year(quiz_year)
    events.each do |event|
      tmp << StudentQuiz.for_event(event).map(&:student_id).uniq
    end
    students_this_year = tmp.flatten.compact.uniq
  end

  def self.filter_out_results_for_division(quizzers, division)
    first_pass = Array.new
    refined = Array.new
    # on first pass, remove any event_quiz results from another division
    quizzers.each do |year_quizzer|
      first_pass << year_quizzer if !year_quizzer.results.select{|r| !r.student_quizzes.empty?}.empty?
      # year_quizzer.results.delete_if{|r| r.student_quizzes.empty? || r.student_quizzes.first.quiz.division != division}

    end
    # on second pass, add any quizzers who have results in this division
    quizzers.each do |year_quizzer|
      refined << year_quizzer unless year_quizzer.results.empty?
    end
    # return the revised quizzer results
    refined
  end
  
  def get_final_team_this_year
    # the team last on is the team we credit student being on...
    teams_for_this_year = StudentTeam.where(student_id: quizzer.id).
    if teams_for_this_year.nil? || teams_for_this_year.empty?
      "N/A"
    else
      teams_for_this_year.last.team.name
    end
  end

end