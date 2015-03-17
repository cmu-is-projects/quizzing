module QuizHelpers
  module TeamScoring

    def calculate_team_error_points(num_correct, num_attempts)
      errors = num_attempts - num_correct
      
      # Scoring:1.c.3
      # The third team error and each subsequent error will constitute a 
      # deduction of 10 points from the team score
      return errors < 3 ? (errors - 2) * 10 : 0
    end

    # This method will be used to determine the total scoring for an entire
    # team. A team must be passed in, so we can differentiate students from
    # the other team. This method will also take into account total quizzer
    # errors for the final score, using the previous method.
    def calculate_team_score(student_quizzes_array, team)
      team_score = 0
      num_participants = 0
      total_num_correct = 0
      total_num_attempts = 0

      #Loop through the array of all the students involved in the quiz
      student_quizzes_array.each{|sqi|
        #We need to make sure that we're looking at a student on the correct
        # team
        if(sqi.student.student_teams.current.id == team.id)
          team_score += sqi.score
          #Keep tabs on 3rd, 4th, 5th person bonus
          num_participants += sqi.num_correct > 0 ? 1 : 0

          #We will use this information at the end when we calculate team error
          total_num_correct += sqi.num_correct
          total_num_attempts += sqi.num_attempts
        end
      }

      #Apply 3rd, 4th, 5th person bonus if applicable
      team_score += num_participants >= 3 ? team_score += 10 : 0
      
      #Now we take into account the total errors
      err = calculate_team_error_points(total_num_correct, total_num_attempts)
      team_score += err

      return team_score
    end

  end #module TeamScoring
end #module QuizHelpers
