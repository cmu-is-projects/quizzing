module ResultCalculator  
  def self.find_most_improved(organization, division)
    students = organization.current_students_for_division(division)
    events = Event.past.chronological
    return Array.new if events.size < 2
    last_event = events.pop
    previous_event = events.pop
    improved = Array.new
    students.each do |student|
      last_result = EventQuizzer.new(student, last_event)
      previous_result = EventQuizzer.new(student, previous_event)
      diff = last_result.total_points - previous_result.total_points
      tmp = [student,last_result.total_points, diff, last_result.accuracy]
      improved << tmp
    end
    improved = improved.sort_by{|i| i[2]}.reverse
    return improved
  end
end