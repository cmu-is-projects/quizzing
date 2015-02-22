class QuizYear
  def initialize(start_year=nil,end_year=nil)
    if start_date.nil? && end_date.nil? 
      find_default_dates 
    else
      end_year ||= start_year + 1
      @start_date = Date.new(start_year,8,1)
      @end_date   = Date.new(end_year,7,31)
    end
  end
  
  attr_reader :start_date, :end_date
  
  def include?(date)
    (start_date..end_date).cover?(date)
  end

  def events
    # return an array of all events scheduled for this quiz year
  end

  def completed_events
    # returns an array of events that essentially have scores associated with them
  end

  private
  def find_default_dates
    year  = Date.today.year
    month = Date.today.month
    if month < 8
      start_year = year - 1
      end_year   = year
    else
      start_year = year
      end_year   = year + 1
    end
    @start_date = Date.new(start_year,8,1)
    @end_date   = Date.new(end_year,7,31)
  end
  
end

