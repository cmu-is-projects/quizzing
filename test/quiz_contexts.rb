module Contexts
  module QuizContexts

    def create_quizzes
      @quiz1 = FactoryGirl.create(:quiz, division: @division1, event: @event1)
      @quiz2 = FactoryGirl.create(:quiz, room_num: 2, round_num: 2, division: @division1, event: @event1)
      @quiz3 = FactoryGirl.create(:quiz, room_num: 3, division_id: 2, round_num: 3, division: @division1, event: @event1)
      @quiz4 = FactoryGirl.create(:quiz, event_id: 2, round_num: 4, division: @division1, event: @event1)
      @quiz_inactive = FactoryGirl.create(:quiz, active: false, round_num: 5, division: @division1, event: @event1)
      
    end
    
    def delete_quizzes
      @quiz1.delete
      @quiz2.delete
      @quiz3.delete
      @quiz4.delete
      @quiz_inactive.delete
    end
  
  end
end
