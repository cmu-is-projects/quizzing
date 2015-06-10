module MatrixGenerator
  def self.get_matrix_for_event_and_division(event, division)
    quizzes = event.quizzes.for_division(division).by_round_and_room
    matrix = Array.new
    quizzes.each do |quiz|
      quiz_teams = quiz.quiz_teams.by_place
      tmp = [quiz.round_num.to_i, quiz.room_num.to_i, quiz_teams[0], quiz_teams[1], quiz_teams[2]]
      matrix << tmp
    end
    return matrix
  end
end