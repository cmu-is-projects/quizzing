class NullEvent
  def start_date
    Date.today
  end

  def end_date
    Date.today
  end

  def start_time
    Time.now
  end

  def num_rounds
    6
  end

  def organization
    NullOrganization.new
  end

  def quizzes
    [NullQuiz.new]
  end
end
