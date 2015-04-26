module Contexts
  module QuizTeamContexts

    def create_acac_quiz_teams_for_past_event
      @quiz1_acac1 = FactoryGirl.create(:quiz_team, quiz: @quiz1, team: @acac_sr1, raw_score: 200, points: 20)
      @quiz2_acac1 = FactoryGirl.create(:quiz_team, quiz: @quiz2, team: @acac_sr1, raw_score: 150, points: 15)
      @quiz3_acac1 = FactoryGirl.create(:quiz_team, quiz: @quiz3, team: @acac_sr1, raw_score: 40, points: 5)
      @quiz4_acac1 = FactoryGirl.create(:quiz_team, quiz: @quiz4, team: @acac_sr1, raw_score: 140, points: 14)
      @quiz5_acac1 = FactoryGirl.create(:quiz_team, quiz: @quiz5, team: @acac_sr1, raw_score: 200, points: 20)
      @quiz6_acac1 = FactoryGirl.create(:quiz_team, quiz: @quiz6, team: @acac_sr1, raw_score: 190, points: 19)
    end

    def create_quiz_teams_for_past_event
      create_acac_quiz_teams_for_past_event
      @quiz1_somerset = FactoryGirl.create(:quiz_team, quiz: @quiz1, team: @somerset_sr1, raw_score: 40, points: 2)
      @quiz2_somerset = FactoryGirl.create(:quiz_team, quiz: @quiz2, team: @somerset_sr1, raw_score: 50, points: 5)
      @quiz3_somerset = FactoryGirl.create(:quiz_team, quiz: @quiz3, team: @somerset_sr1, raw_score: 100, points: 10)
      @quiz4_somerset = FactoryGirl.create(:quiz_team, quiz: @quiz4, team: @somerset_sr1, raw_score: 60, points: 4)
      @quiz5_somerset = FactoryGirl.create(:quiz_team, quiz: @quiz5, team: @somerset_sr1, raw_score: 60, points: 5)
      @quiz6_somerset = FactoryGirl.create(:quiz_team, quiz: @quiz6, team: @somerset_sr1, raw_score: -10, points: 1)
    end

    def create_quiz_teams_for_future_event
      #when using in quiz_team_test contexts, 
      #must first use create_quizzes_for_future_event before this
      @quiz1f_acac2 = FactoryGirl.create(:quiz_team, quiz: @quiz1f, team: @acac_sr2)
      @quiz2f_acac2 = FactoryGirl.create(:quiz_team, quiz: @quiz2f, team: @acac_sr2)
      @quiz3f_acac2 = FactoryGirl.create(:quiz_team, quiz: @quiz3f, team: @acac_sr2)
      @quiz4f_acac2 = FactoryGirl.create(:quiz_team, quiz: @quiz4f, team: @acac_sr2)
      @quiz5f_acac2 = FactoryGirl.create(:quiz_team, quiz: @quiz5f, team: @acac_sr2)
      @quiz6f_acac2 = FactoryGirl.create(:quiz_team, quiz: @quiz6f, team: @acac_sr2)
    end

    def delete_acac_quiz_teams_for_past_event
      @quiz1_acac1.delete
      @quiz2_acac1.delete
      @quiz3_acac1.delete
      @quiz4_acac1.delete
      @quiz5_acac1.delete
      @quiz6_acac1.delete
    end

    def delete_quiz_teams_for_past_event
      delete_acac_quiz_teams_for_past_event
      @quiz1_somerset.delete
      @quiz2_somerset.delete
      @quiz3_somerset.delete
      @quiz4_somerset.delete
      @quiz5_somerset.delete
      @quiz6_somerset.delete
    end

    def delete_quiz_teams_for_future_event
      @quiz1f_acac2.delete
      @quiz2f_acac2.delete
      @quiz3f_acac2.delete
      @quiz4f_acac2.delete
      @quiz5f_acac2.delete
      @quiz6f_acac2.delete      
    end
  end
end