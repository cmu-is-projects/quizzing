module Contexts
  module ExtendedQuizzesContexts

    def create_year_quizzers
      @year_quizzer_1 = YearQuizzer.new(@mark)
      @year_quizzer_2 = YearQuizzer.new(@alex)
      @year_quizzer_3 = YearQuizzer.new(@jimmy)
      @year_quizzer_4 = YearQuizzer.new(@jonathan)
    end

    def remove_year_quizzers
      @year_quizzer_1 = nil
      @year_quizzer_2 = nil
      @year_quizzer_3 = nil
      @year_quizzer_4 = nil      
    end

    #written by Theophilus
    def create_year_teams
      @year_team_1 = YearTeam.new(@acac_jr1)
      @year_team_2 = YearTeam.new(@acac_sr3)
      @year_team_3 = YearTeam.new(@acac_sr1)
      @year_team_4 = YearTeam.new(@somerset_sr1)
    end

    def remove_year_teams
      @year_team_1 = nil          
      @year_team_2 = nil 
      @year_team_3 = nil
      @year_team_4 = nil
    end
    #end written by Theophilus

    # assumes create_students, create_one_event (and related) already run
    def create_three_more_complete_quiz_contexts
      create_three_more_past_events
      create_quizzes_for_past_events
      assign_teams_to_past_quizzes
      create_results_for_mark
      create_results_for_alex
      create_results_for_jimmy
    end

    def create_three_more_past_events
      # already have one event two weeks in past, so ...
      # creates one event that occurred four weeks in the past
      @event4 = FactoryGirl.create(:event, organization: @acac, start_date: 2.weeks.from_now.to_date, end_date: 2.weeks.from_now.to_date)
      @event4.update_attribute(:start_date, 4.weeks.ago.to_date)
      @event4.update_attribute(:end_date, 4.weeks.ago.to_date)

      # creates one event that occurred six weeks in the past
      @event6 = FactoryGirl.create(:event, organization: @acac, start_date: 2.weeks.from_now.to_date, end_date: 2.weeks.from_now.to_date)
      @event6.update_attribute(:start_date, 6.weeks.ago.to_date)
      @event6.update_attribute(:end_date, 6.weeks.ago.to_date)

      # creates one event that occurred eight weeks in the past
      @event8 = FactoryGirl.create(:event, organization: @acac, start_date: 2.weeks.from_now.to_date, end_date: 2.weeks.from_now.to_date)
      @event8.update_attribute(:start_date, 8.weeks.ago.to_date)
      @event8.update_attribute(:end_date, 8.weeks.ago.to_date)
    end

    def create_quizzes_for_past_events
      @quiz1_4 = FactoryGirl.create(:quiz, event: @event4, division: @senior_a, round_num: 1)
      @quiz2_4 = FactoryGirl.create(:quiz, event: @event4, division: @senior_a, round_num: 2)
      @quiz3_4 = FactoryGirl.create(:quiz, event: @event4, division: @senior_a, round_num: 3)
      @quiz4_4 = FactoryGirl.create(:quiz, event: @event4, division: @senior_a, round_num: 4)
      @quiz5_4 = FactoryGirl.create(:quiz, event: @event4, division: @senior_a, round_num: 5)
      @quiz6_4 = FactoryGirl.create(:quiz, event: @event4, division: @senior_a, round_num: 6)

      @quiz1_6 = FactoryGirl.create(:quiz, event: @event6, division: @senior_a, round_num: 1)
      @quiz2_6 = FactoryGirl.create(:quiz, event: @event6, division: @senior_a, round_num: 2)
      @quiz3_6 = FactoryGirl.create(:quiz, event: @event6, division: @senior_a, round_num: 3)
      @quiz4_6 = FactoryGirl.create(:quiz, event: @event6, division: @senior_a, round_num: 4)
      @quiz5_6 = FactoryGirl.create(:quiz, event: @event6, division: @senior_a, round_num: 5)
      @quiz6_6 = FactoryGirl.create(:quiz, event: @event6, division: @senior_a, round_num: 6)

      @quiz1_8 = FactoryGirl.create(:quiz, event: @event8, division: @senior_a, round_num: 1)
      @quiz2_8 = FactoryGirl.create(:quiz, event: @event8, division: @senior_a, round_num: 2)
      @quiz3_8 = FactoryGirl.create(:quiz, event: @event8, division: @senior_a, round_num: 3)
      @quiz4_8 = FactoryGirl.create(:quiz, event: @event8, division: @senior_a, round_num: 4)
      @quiz5_8 = FactoryGirl.create(:quiz, event: @event8, division: @senior_a, round_num: 5)
      @quiz6_8 = FactoryGirl.create(:quiz, event: @event8, division: @senior_a, round_num: 6)
    end

    def assign_teams_to_past_quizzes
      @quiz1_4_acac1 = FactoryGirl.create(:quiz_team, quiz: @quiz1_4, team: @acac_sr1)
      @quiz2_4_acac1 = FactoryGirl.create(:quiz_team, quiz: @quiz2_4, team: @acac_sr1)
      @quiz3_4_acac1 = FactoryGirl.create(:quiz_team, quiz: @quiz3_4, team: @acac_sr1)
      @quiz4_4_acac1 = FactoryGirl.create(:quiz_team, quiz: @quiz4_4, team: @acac_sr1)
      @quiz5_4_acac1 = FactoryGirl.create(:quiz_team, quiz: @quiz5_4, team: @acac_sr1)
      @quiz6_4_acac1 = FactoryGirl.create(:quiz_team, quiz: @quiz6_4, team: @acac_sr1)

      @quiz1_6_acac1 = FactoryGirl.create(:quiz_team, quiz: @quiz1_6, team: @acac_sr1)
      @quiz2_6_acac1 = FactoryGirl.create(:quiz_team, quiz: @quiz2_6, team: @acac_sr1)
      @quiz3_6_acac1 = FactoryGirl.create(:quiz_team, quiz: @quiz3_6, team: @acac_sr1)
      @quiz4_6_acac1 = FactoryGirl.create(:quiz_team, quiz: @quiz4_6, team: @acac_sr1)
      @quiz5_6_acac1 = FactoryGirl.create(:quiz_team, quiz: @quiz5_6, team: @acac_sr1)
      @quiz6_6_acac1 = FactoryGirl.create(:quiz_team, quiz: @quiz6_6, team: @acac_sr1)

      @quiz1_8_acac1 = FactoryGirl.create(:quiz_team, quiz: @quiz1_8, team: @acac_sr1)
      @quiz2_8_acac1 = FactoryGirl.create(:quiz_team, quiz: @quiz2_8, team: @acac_sr1)
      @quiz3_8_acac1 = FactoryGirl.create(:quiz_team, quiz: @quiz3_8, team: @acac_sr1)
      @quiz4_8_acac1 = FactoryGirl.create(:quiz_team, quiz: @quiz4_8, team: @acac_sr1)
      @quiz5_8_acac1 = FactoryGirl.create(:quiz_team, quiz: @quiz5_8, team: @acac_sr1)
      @quiz6_8_acac1 = FactoryGirl.create(:quiz_team, quiz: @quiz6_8, team: @acac_sr1)

      @quiz1_4_somerset = FactoryGirl.create(:quiz_team, quiz: @quiz1_4, team: @somerset_sr1)
      @quiz2_4_somerset = FactoryGirl.create(:quiz_team, quiz: @quiz2_4, team: @somerset_sr1)
      @quiz3_4_somerset = FactoryGirl.create(:quiz_team, quiz: @quiz3_4, team: @somerset_sr1)
      @quiz4_4_somerset = FactoryGirl.create(:quiz_team, quiz: @quiz4_4, team: @somerset_sr1)
      @quiz5_4_somerset = FactoryGirl.create(:quiz_team, quiz: @quiz5_4, team: @somerset_sr1)
      @quiz6_4_somerset = FactoryGirl.create(:quiz_team, quiz: @quiz6_4, team: @somerset_sr1)

      @quiz1_6_somerset = FactoryGirl.create(:quiz_team, quiz: @quiz1_6, team: @somerset_sr1)
      @quiz2_6_somerset = FactoryGirl.create(:quiz_team, quiz: @quiz2_6, team: @somerset_sr1)
      @quiz3_6_somerset = FactoryGirl.create(:quiz_team, quiz: @quiz3_6, team: @somerset_sr1)
      @quiz4_6_somerset = FactoryGirl.create(:quiz_team, quiz: @quiz4_6, team: @somerset_sr1)
      @quiz5_6_somerset = FactoryGirl.create(:quiz_team, quiz: @quiz5_6, team: @somerset_sr1)
      @quiz6_6_somerset = FactoryGirl.create(:quiz_team, quiz: @quiz6_6, team: @somerset_sr1)

      @quiz1_8_somerset = FactoryGirl.create(:quiz_team, quiz: @quiz1_8, team: @somerset_sr1)
      @quiz2_8_somerset = FactoryGirl.create(:quiz_team, quiz: @quiz2_8, team: @somerset_sr1)
      @quiz3_8_somerset = FactoryGirl.create(:quiz_team, quiz: @quiz3_8, team: @somerset_sr1)
      @quiz4_8_somerset = FactoryGirl.create(:quiz_team, quiz: @quiz4_8, team: @somerset_sr1)
      @quiz5_8_somerset = FactoryGirl.create(:quiz_team, quiz: @quiz5_8, team: @somerset_sr1)
      @quiz6_8_somerset = FactoryGirl.create(:quiz_team, quiz: @quiz6_8, team: @somerset_sr1)
    end

    def create_results_for_mark
      # note Mark misses event6 to test handling absences; should drop a zero for missing event
      @mark1_4 = FactoryGirl.create(:student_quiz, student: @mark, quiz: @quiz1_4, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @mark2_4 = FactoryGirl.create(:student_quiz, student: @mark, quiz: @quiz2_4, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @mark3_4 = FactoryGirl.create(:student_quiz, student: @mark, quiz: @quiz3_4, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @mark4_4 = FactoryGirl.create(:student_quiz, student: @mark, quiz: @quiz4_4, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @mark5_4 = FactoryGirl.create(:student_quiz, student: @mark, quiz: @quiz5_4, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @mark6_4 = FactoryGirl.create(:student_quiz, student: @mark, quiz: @quiz6_4, num_correct: 4, num_attempts: 4, num_fouls: 0)   

      @mark1_8 = FactoryGirl.create(:student_quiz, student: @mark, quiz: @quiz1_8, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @mark2_8 = FactoryGirl.create(:student_quiz, student: @mark, quiz: @quiz2_8, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @mark3_8 = FactoryGirl.create(:student_quiz, student: @mark, quiz: @quiz3_8, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @mark4_8 = FactoryGirl.create(:student_quiz, student: @mark, quiz: @quiz4_8, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @mark5_8 = FactoryGirl.create(:student_quiz, student: @mark, quiz: @quiz5_8, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @mark6_8 = FactoryGirl.create(:student_quiz, student: @mark, quiz: @quiz6_8, num_correct: 4, num_attempts: 4, num_fouls: 0)   
    end

    def create_results_for_alex
      # Alex has a non-zero score to drop in adjusted pts; more total pts but less adjusted pts than Mark
      @alex1_4 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz1_4, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @alex2_4 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz2_4, num_correct: 4, num_attempts: 5, num_fouls: 0)
      @alex3_4 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz3_4, num_correct: 4, num_attempts: 5, num_fouls: 0)
      @alex4_4 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz4_4, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @alex5_4 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz5_4, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @alex6_4 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz6_4, num_correct: 4, num_attempts: 6, num_fouls: 0)

      @alex1_6 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz1_6, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @alex2_6 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz2_6, num_correct: 4, num_attempts: 5, num_fouls: 0)
      @alex3_6 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz3_6, num_correct: 4, num_attempts: 5, num_fouls: 0)
      @alex4_6 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz4_6, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @alex5_6 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz5_6, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @alex6_6 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz6_6, num_correct: 4, num_attempts: 6, num_fouls: 0)

      @alex1_8 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz1_8, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @alex2_8 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz2_8, num_correct: 4, num_attempts: 5, num_fouls: 0)
      @alex3_8 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz3_8, num_correct: 4, num_attempts: 5, num_fouls: 0)
      @alex4_8 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz4_8, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @alex5_8 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz5_8, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @alex6_8 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz6_8, num_correct: 4, num_attempts: 6, num_fouls: 0)
    end

    def create_results_for_jimmy
      # Jimmy already has a negative score, will give a zero also to test right drop...
      @jimmy1_4 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz1_4, num_correct: 0, num_attempts: 0, num_fouls: 0)
      @jimmy2_4 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz2_4, num_correct: 0, num_attempts: 1, num_fouls: 1)
      @jimmy3_4 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz3_4, num_correct: 0, num_attempts: 0, num_fouls: 0)
      @jimmy4_4 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz4_4, num_correct: 0, num_attempts: 0, num_fouls: 0)
      @jimmy5_4 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz5_4, num_correct: 0, num_attempts: 1, num_fouls: 0)
      @jimmy6_4 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz6_4, num_correct: 0, num_attempts: 0, num_fouls: 1)

      @jimmy1_6 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz1_6, num_correct: 0, num_attempts: 0, num_fouls: 0)
      @jimmy2_6 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz2_6, num_correct: 0, num_attempts: 0, num_fouls: 1)
      @jimmy3_6 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz3_6, num_correct: 1, num_attempts: 1, num_fouls: 3)
      @jimmy4_6 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz4_6, num_correct: 0, num_attempts: 0, num_fouls: 0)
      @jimmy5_6 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz5_6, num_correct: 0, num_attempts: 0, num_fouls: 2)
      @jimmy6_6 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz6_6, num_correct: 0, num_attempts: 0, num_fouls: 1)

      @jimmy1_8 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz1_8, num_correct: 1, num_attempts: 2, num_fouls: 0)
      @jimmy2_8 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz2_8, num_correct: 0, num_attempts: 0, num_fouls: 1)
      @jimmy3_8 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz3_8, num_correct: 1, num_attempts: 1, num_fouls: 0)
      @jimmy4_8 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz4_8, num_correct: 0, num_attempts: 3, num_fouls: 0)
      @jimmy5_8 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz5_8, num_correct: 2, num_attempts: 2, num_fouls: 2)
      @jimmy6_8 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz6_8, num_correct: 1, num_attempts: 1, num_fouls: 1)
    end

    def delete_three_more_complete_quiz_contexts
      @jimmy1_4.delete
      @jimmy2_4.delete
      @jimmy3_4.delete
      @jimmy4_4.delete
      @jimmy5_4.delete
      @jimmy6_4.delete
      @jimmy1_6.delete
      @jimmy2_6.delete
      @jimmy3_6.delete
      @jimmy4_6.delete
      @jimmy5_6.delete
      @jimmy6_6.delete
      @jimmy1_8.delete
      @jimmy2_8.delete
      @jimmy3_8.delete
      @jimmy4_8.delete
      @jimmy5_8.delete
      @jimmy6_8.delete
      @alex1_4.delete
      @alex2_4.delete
      @alex3_4.delete
      @alex4_4.delete
      @alex5_4.delete
      @alex6_4.delete
      @alex1_6.delete
      @alex2_6.delete
      @alex3_6.delete
      @alex4_6.delete
      @alex5_6.delete
      @alex6_6.delete
      @alex1_8.delete
      @alex2_8.delete
      @alex3_8.delete
      @alex4_8.delete
      @alex5_8.delete
      @alex6_8.delete
      @mark1_4.delete
      @mark2_4.delete
      @mark3_4.delete
      @mark4_4.delete
      @mark5_4.delete
      @mark6_4.delete
      @mark1_8.delete
      @mark2_8.delete
      @mark3_8.delete
      @mark4_8.delete
      @mark5_8.delete
      @mark6_8.delete
      @quiz1_4_acac1.delete
      @quiz2_4_acac1.delete
      @quiz3_4_acac1.delete
      @quiz4_4_acac1.delete
      @quiz5_4_acac1.delete
      @quiz6_4_acac1.delete
      @quiz1_6_acac1.delete
      @quiz2_6_acac1.delete
      @quiz3_6_acac1.delete
      @quiz4_6_acac1.delete
      @quiz5_6_acac1.delete
      @quiz6_6_acac1.delete
      @quiz1_8_acac1.delete
      @quiz2_8_acac1.delete
      @quiz3_8_acac1.delete
      @quiz4_8_acac1.delete
      @quiz5_8_acac1.delete
      @quiz6_8_acac1.delete
      @quiz1_4_somerset.delete
      @quiz2_4_somerset.delete
      @quiz3_4_somerset.delete
      @quiz4_4_somerset.delete
      @quiz5_4_somerset.delete
      @quiz6_4_somerset.delete
      @quiz1_6_somerset.delete
      @quiz2_6_somerset.delete
      @quiz3_6_somerset.delete
      @quiz4_6_somerset.delete
      @quiz5_6_somerset.delete
      @quiz6_6_somerset.delete
      @quiz1_8_somerset.delete
      @quiz2_8_somerset.delete
      @quiz3_8_somerset.delete
      @quiz4_8_somerset.delete
      @quiz5_8_somerset.delete
      @quiz6_8_somerset.delete
      @quiz1_4.delete
      @quiz2_4.delete
      @quiz3_4.delete
      @quiz4_4.delete
      @quiz5_4.delete
      @quiz6_4.delete
      @quiz1_6.delete
      @quiz2_6.delete
      @quiz3_6.delete
      @quiz4_6.delete
      @quiz5_6.delete
      @quiz6_6.delete
      @quiz1_8.delete
      @quiz2_8.delete
      @quiz3_8.delete
      @quiz4_8.delete
      @quiz5_8.delete
      @quiz6_8.delete
      @event4.delete
      @event6.delete
      @event8.delete
    end
  end
end