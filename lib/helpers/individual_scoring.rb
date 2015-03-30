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
      #Scoring rule 2B1:
      #When a quizzer makes a second error within a quiz 10 points are deducted
      #from his individual score. An additional 10 points are deducted for his 
      #third error.
      errors = num_attempts - num_correct
      
      return errors > 1 ? (errors - 1) * 10 : 0
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