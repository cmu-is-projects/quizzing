module QuizHelpers
  module IndividualScoring
    def calculate_student_quiz_score(num_correct, num_attempts, num_fouls=0)
      base_score = num_correct * 20
      
      error_points = calculate_error_points(num_correct, num_attempts)
      foul_points = calculate_foul_penalty(num_fouls)
      bonus_points = calculate_bonus_points(num_correct, num_attempts)

      student_score = base_score - error_points - foul_points + bonus_points
      return student_score
    end

    def calculate_error_points(num_correct, num_attempts)
      errors = num_attempts - num_correct
      case errors
      when 2
        penalty = 10
      when 3
        penalty = 20
      else
        penalty = 0
      end
      return penalty
    end

    def calculate_foul_penalty(num_fouls)
      if num_fouls == 3
        penalty = 10
      else
        penalty = 0
      end
      return penalty
    end

    def calculate_bonus_points(num_correct, num_attempts)
      if num_correct == 4 && num_attempts == 4
        bonus = 10
      else
        bonus = 0
      end
      return bonus
    end
  end
end