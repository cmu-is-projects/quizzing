class EventTeam
  def initialize(team, event)
    @team = team
    @name = team.name
    @event = event
    @students = team.students
    @quiz_teams = get_all_quiz_teams_for_team_in_this_event
  end

  attr_reader :event, :team, :students, :name, :quiz_teams

  def total_score
    #Top down; go to QuizTeam
    quiz_teams.inject(0){|sum, quiz_team| sum += quiz_team.raw_score}
  end
  
  def get_all_quiz_teams_for_team_in_this_event
    quiz_teams = QuizTeam.for_team(team).for_event(event).by_round_num.to_a
  end

  #Necessary for event details page
  #   def self.get_all_quizzers_for_event(event)
  #   all_students_at_event = StudentQuiz.for_event(event).map(&:student_id).uniq
  #   quizzers = Array.new
  #   all_students_at_event.each do |stu_id|
  #     event_quizzer = EventQuizzer.new(Student.find(stu_id), event)
  #     quizzers << event_quizzer
  #   end
  #   # returned a sorted array of event_quizzers in descending order of average points
  #   # (until end when avg and total align, averages rule the day in reporting results)
  #   sorted = quizzers.sort_by{|eq| eq.average_points}.reverse
  # end

  # def self.get_all_quizzers_for_event_and_division(event, division)
  #   event_quizzers = EventQuizzer.get_all_quizzers_for_event(event)
  #   in_division = Array.new
  #   event_quizzers.each do |event_quizzer|
  #     in_division << event_quizzer if event_quizzer.division == division
  #   end
  #   # resort just to be safe...
  #   final = in_division.sort_by{|eq| eq.average_points}.reverse 
  # end
end #class EventTeam