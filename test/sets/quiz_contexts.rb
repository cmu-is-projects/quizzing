module Contexts
  module QuizContexts

    # assumes create_events and create_divisions already run
    def create_quizzes_for_past_event
      @quiz1 = FactoryGirl.create(:quiz, event: @event, division: @senior_a, round_num: 1)
      @quiz2 = FactoryGirl.create(:quiz, event: @event, division: @senior_a, round_num: 2)
      @quiz3 = FactoryGirl.create(:quiz, event: @event, division: @senior_a, round_num: 3)
      @quiz4 = FactoryGirl.create(:quiz, event: @event, division: @senior_a, round_num: 4)
      @quiz5 = FactoryGirl.create(:quiz, event: @event, division: @senior_a, round_num: 5)
      @quiz6 = FactoryGirl.create(:quiz, event: @event, division: @senior_a, round_num: 6)
      @quiz_inactive = FactoryGirl.create(:quiz, event: @event, division: @senior_a, active: false)
    end
    
    def delete_quizzes_for_past_event
      @quiz1.delete
      @quiz2.delete
      @quiz3.delete
      @quiz4.delete
      @quiz5.delete
      @quiz6.delete
      @quiz_inactive.delete
    end

    def create_quizzes_for_present_event
      @quiz1p = FactoryGirl.create(:quiz, event: @event1, division: @senior_a, round_num: 1)
      @quiz2p = FactoryGirl.create(:quiz, event: @event1, division: @senior_a, round_num: 2)
      @quiz3p = FactoryGirl.create(:quiz, event: @event1, division: @senior_a, round_num: 3)
      @quiz4p = FactoryGirl.create(:quiz, event: @event1, division: @senior_a, round_num: 4)
      @quiz5p = FactoryGirl.create(:quiz, event: @event1, division: @senior_a, round_num: 5)
      @quiz6p = FactoryGirl.create(:quiz, event: @event1, division: @senior_a, round_num: 6)
    end
    
    def delete_quizzes_for_present_event
      @quiz1p.delete
      @quiz2p.delete
      @quiz3p.delete
      @quiz4p.delete
      @quiz5p.delete
      @quiz6p.delete
    end

    def create_quizzes_for_future_event
      #causes student_quizzes with nil fields
      @quiz1f = FactoryGirl.create(:quiz, event: @event3, division: @senior_a, round_num: 1)
      @quiz2f = FactoryGirl.create(:quiz, event: @event3, division: @senior_a, round_num: 2)
      @quiz3f = FactoryGirl.create(:quiz, event: @event3, division: @senior_a, round_num: 3)
      @quiz4f = FactoryGirl.create(:quiz, event: @event3, division: @senior_a, round_num: 4)
      @quiz5f = FactoryGirl.create(:quiz, event: @event3, division: @senior_a, round_num: 5)
      @quiz6f = FactoryGirl.create(:quiz, event: @event3, division: @senior_a, round_num: 6)
    end
    
    def delete_quizzes_for_future_event
      @quiz1f.delete
      @quiz2f.delete
      @quiz3f.delete
      @quiz4f.delete
      @quiz5f.delete
      @quiz6f.delete
    end
  end
end
