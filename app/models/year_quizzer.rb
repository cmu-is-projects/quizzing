class YearQuizzer
  def initialize(quizzer, start_year=nil)
    @year = QuizYear.new(start_year)
    @quizzer = quizzer
    @name = quizzer.proper_name
    @team_name = quizzer.current_team.name
    @events = [] # an array of all scored events this quiz year
  end

  attr_reader :quizzer
  attr_reader :name, :team_name, :events

  def total_points
    # calculate the total points for this quizzer in this quiz year
  end

  def lowest_points
    # calculate the least amount of points this quizzer earned in an event this quiz year
  end

  def adjusted_points
    # calculate the total points minus the lowest_points (if number of events > 3)
  end

  def total_accuracy
    # calculate the accuracy rate for this quizzer in all events this quiz year
  end

  def adjusted_accuracy
    # calculate the accuracy rate for this quizzer after dropping worst event this quiz year
  end
  
  
end