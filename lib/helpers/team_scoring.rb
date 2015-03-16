module QuizHelpers
  module TeamScoring

    def calculate_team_error_points(num_correct, num_attempts)
      errors = num_attempts - num_correct
      
      # Scoring:1.c.3
      # The third team error and each subsequent error will constitute a 
      # deduction of 10 points from the team score
      return errors < 3 ? (errors - 2) * 10 : 0
    end

    def calculate_team_score(student_quizzes_array, team)
      team_score = 0
      num_participants = 0

      #Loop through the array of all the students involved in the quiz
      student_quizzes_array.each{|sqi|
        #We need to make sure that we're looking at a student on the correct
        # team
        if(sqi.student.student_teams.current.id == team.id)
          team_score += sqi.score
          #Keep tabs on 3rd, 4th, 5th person bonus
          num_participants += sqi.num_correct > 0 ? 1 : 0
        end
      }

      #Apply 3rd, 4th, 5th person bonus if applicable
      team_score += num_participants >= 3 ? team_score += 10 : 0
    end

  end #module TeamScoring
end #module QuizHelpers
