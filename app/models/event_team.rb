class EventTeam
  def initialize(team, event)
    @team = team
    @name = team.name
    @event = event
    @students = team.students
    @division = team.division
    @event_host = event.organization.name
    @quiz_teams = get_all_quiz_teams_for_team_in_this_event
  end

  attr_reader :event, :team, :students, :name, :quiz_teams, :division, :event_host

  def total_points
    quiz_teams.inject(0){|sum, quiz_team| sum += (quiz_team.points.nil? ? 0 : quiz_team.points)}
  end

  def total_raw_score
    quiz_teams.inject(0){|sum, quiz_team| sum += (quiz_team.raw_score.nil? ? 0 : quiz_team.raw_score)}
  end

  def accuracy
    eq_array = students.map{|s| EventQuizzer.new(s,event)}
    total_correct = eq_array.map{|s| s.student_quizzes.inject(0){|sum,sq| sum+=sq.num_correct}}.sum
    total_attempts = eq_array.map{|s| s.student_quizzes.inject(0){|sum,sq| sum+=sq.num_attempts}}.sum
    if total_attempts.zero?
      acc_rate = 0.0
    else
      acc_rate = (total_correct.to_f / total_attempts).round(3)
    end
  end
  
  def get_all_quiz_teams_for_team_in_this_event
    quiz_teams = QuizTeam.for_team(team).for_event(event).by_round_num.to_a
  end

  #Necessary for event details page
    def self.get_all_teams_for_event(event)
    all_teams_at_event = QuizTeam.for_event(event).map(&:team_id).uniq
    teams = Array.new
    all_teams_at_event.each do |team_id|
      event_team = EventTeam.new(Team.find(team_id), event)
      teams << event_team
    end
    # returned a sorted array of event_teams in descending order of average points
    # (until end when avg and total align, averages rule the day in reporting results)
    sorted = teams.sort_by{|et| et.total_points}.reverse
  end

  def self.get_all_teams_for_event_and_division(event, division)
    event_teams = EventTeam.get_all_teams_for_event(event)
    in_division = Array.new
    event_teams.each do |event_team|
      in_division << event_team if event_team.division == division
    end
    # resort just to be safe...
    final = in_division.sort_by{|et| et.total_points}.reverse 
  end

  def self.get_average_score(division)
    average_scores = Array.new
    Event.all.each do |e|
      score = 0
      EventTeam.get_all_teams_for_event_and_division(e, division).each do |t|
        score += EventTeam.new(t,e).total_points
      end
      a = EventTeam.get_all_teams_for_event(e).length
      score= score / a
      average_scores << score
    end 
    return average_scores
  end





end #class EventTeam








