module QuizHelpers
  module TeamScoring

    def calculate_team_error_points(num_correct, num_attempts)
      errors = num_attempts - num_correct
      
      # Scoring:1.c.3
      # The third team error and each subsequent error will constitute a 
      # deduction of 10 points from the team score
      return errors > 2 ? (errors - 2) * 10 : 0
    end

    def calculate_team_fouls(total_fouls)
      return ((total_fouls/3)) * 10
    end

    def calculate_failed_challenge_deduction(num_failed)
      return num_failed > 1 ? (num_failed-1) * 10 : 0
    end

    # raw score and points are provided Spring '15 so commenting out
    # def calculate_team_points_from_raw_score(raw_score)
    #   return points > 100 ? (((points)/10)) : 10  
    # end

    # This method will be used to determine the total scoring for an entire
    # team. A team must be passed in, so we can differentiate students from
    # the other team. This method will also take into account total quizzer
    # errors for the final score, using the previous method - calculate_team_points_from_score(points).
    def calculate_team_quiz_score(student_quizzes_array, team)
      team_score = 0
      num_participants = 0
      total_num_correct = 0
      total_num_attempts = 0
      total_fouls = 0

      #Loop through the array of all the students involved in the quiz
      student_quizzes_array.each{|sqi|
        #We need to make sure that we're looking at a student on the correct
        # team
        #TODO: next code-line gives error undefined method `id' for #<ActiveRecord::AssociationRelation::ActiveRecord_AssociationRelation_StudentTeam:0x230831f8>
        #would be nice to utilize EventTeam's get_all_team_quizzes_for_team_in_this_event so we don't have to check for the right team
        if(sqi.student.student_teams.current.team.id == team.id)
          team_score += sqi.num_correct * 20
          #Keep tabs on 3rd, 4th, 5th person bonus
          num_participants += sqi.num_correct > 0 ? 1 : 0

          #We will use this information at the end when we calculate team error
          total_num_correct += sqi.num_correct
          total_num_attempts += sqi.num_attempts
          total_fouls += sqi.num_fouls
        end
      }

      #Apply 3rd, 4th, 5th person bonus if applicable
      team_score += num_participants >= 3 ? team_score += 10 : 0
      
      #Now we take into account the total errors
      err = calculate_team_error_points(total_num_correct, total_num_attempts)
      team_score -= err

      #Now we take into account the fouls
      foul = calculate_team_fouls(total_fouls)
      team_score -= foul

      #Now we take into account failed challenges
      quiz_teams_array = student_quizzes_array.fetch(0).quiz.quiz_teams
      q_t = quiz_teams_array.select{|q| q.team.id == team.id}
      chal = calculate_failed_challenge_deduction(q_t.failed_challenges)
      team_score -= challenge
      
      return team_score
    end

  end #module TeamScoring
end #module QuizHelpers
