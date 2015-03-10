module Contexts
  module EventQuizzerContexts
    def create_event_and_division
      @event = FactoryGirl.create(:event, start_date: 2.weeks.from_now.to_date, end_date: 2.weeks.from_now.to_date)
      @event.update_attribute(:start_date, 2.weeks.ago.to_date)
      @event.update_attribute(:end_date, 2.weeks.ago.to_date)
      @senior_a = FactoryGirl.create(:division)
    end

    def delete_event_and_division
      @event.delete
      @senior_a.delete
    end

    def create_students
      @john = FactoryGirl.create(:student)
      @jane = FactoryGirl.create(:student,first_name: "Jane")
      @jimmy = FactoryGirl.create(:student,first_name: "Jimmy")
    end

    def delete_students
      @john.delete
      @jane.delete
      @jimmy.delete
    end

    def create_quizzes
      @quiz1 = FactoryGirl.create(:quiz, event: @event, division: @senior_a, round_num: 1)
      @quiz2 = FactoryGirl.create(:quiz, event: @event, division: @senior_a, round_num: 2)
      @quiz3 = FactoryGirl.create(:quiz, event: @event, division: @senior_a, round_num: 3)
      @quiz4 = FactoryGirl.create(:quiz, event: @event, division: @senior_a, round_num: 4)
      @quiz5 = FactoryGirl.create(:quiz, event: @event, division: @senior_a, round_num: 5)
      @quiz6 = FactoryGirl.create(:quiz, event: @event, division: @senior_a, round_num: 6)
    end

    def delete_quizzes
      @quiz1.delete
      @quiz2.delete
      @quiz3.delete
      @quiz4.delete
      @quiz5.delete
      @quiz6.delete
    end

    def create_student_quizzes
      # student with perfect day
      @john1 = FactoryGirl.create(:student_quiz, student: @john, quiz: @quiz1, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @john2 = FactoryGirl.create(:student_quiz, student: @john, quiz: @quiz2, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @john3 = FactoryGirl.create(:student_quiz, student: @john, quiz: @quiz3, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @john4 = FactoryGirl.create(:student_quiz, student: @john, quiz: @quiz4, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @john5 = FactoryGirl.create(:student_quiz, student: @john, quiz: @quiz5, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @john6 = FactoryGirl.create(:student_quiz, student: @john, quiz: @quiz6, num_correct: 4, num_attempts: 4, num_fouls: 0)

      # student with average day 
      @jane1 = FactoryGirl.create(:student_quiz, student: @jane, quiz: @quiz1, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @jane2 = FactoryGirl.create(:student_quiz, student: @jane, quiz: @quiz2, num_correct: 4, num_attempts: 5, num_fouls: 0)
      @jane3 = FactoryGirl.create(:student_quiz, student: @jane, quiz: @quiz3, num_correct: 3, num_attempts: 5, num_fouls: 0)
      @jane4 = FactoryGirl.create(:student_quiz, student: @jane, quiz: @quiz4, num_correct: 2, num_attempts: 5, num_fouls: 0)
      @jane5 = FactoryGirl.create(:student_quiz, student: @jane, quiz: @quiz5, num_correct: 3, num_attempts: 3, num_fouls: 0)
      @jane6 = FactoryGirl.create(:student_quiz, student: @jane, quiz: @quiz6, num_correct: 0, num_attempts: 1, num_fouls: 0)
   
      # student with negative day 
      @jimmy1 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz1, num_correct: 1, num_attempts: 4, num_fouls: 0)
      @jimmy2 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz2, num_correct: 0, num_attempts: 0, num_fouls: 1)
      @jimmy3 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz3, num_correct: 1, num_attempts: 1, num_fouls: 3)
      @jimmy4 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz4, num_correct: 0, num_attempts: 3, num_fouls: 0)
      @jimmy5 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz5, num_correct: 0, num_attempts: 2, num_fouls: 2)
      @jimmy6 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz6, num_correct: 0, num_attempts: 1, num_fouls: 1)
    end

    def delete_student_quizzes
      @john1.delete
      @john2.delete
      @john3.delete
      @john4.delete
      @john5.delete
      @john6.delete
      @jane1.delete
      @jane2.delete
      @jane3.delete
      @jane4.delete
      @jane5.delete
      @jane6.delete
      @jimmy1.delete
      @jimmy2.delete
      @jimmy3.delete
      @jimmy4.delete
      @jimmy5.delete
      @jimmy6.delete
    end

    def build_context
      create_event_and_division
      create_students
      create_quizzes
      create_student_quizzes
    end

    def destroy_context
      delete_event_and_division
      delete_students
      delete_quizzes
      delete_student_quizzes 
    end
  end
end