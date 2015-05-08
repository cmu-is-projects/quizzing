module Contexts
  module StudentQuizContexts

    # assumes create_students, create_one_event (and related) already run
    def create_student_quizzes
      # student with average day 
      @alex1 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz1, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @alex2 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz2, num_correct: 4, num_attempts: 5, num_fouls: 0)
      @alex3 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz3, num_correct: 3, num_attempts: 5, num_fouls: 0)
      @alex4 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz4, num_correct: 2, num_attempts: 5, num_fouls: 0)
      @alex5 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz5, num_correct: 3, num_attempts: 3, num_fouls: 0)
      @alex6 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz6, num_correct: 0, num_attempts: 1, num_fouls: 0)

      # student with perfect day
      @mark1 = FactoryGirl.create(:student_quiz, student: @mark, quiz: @quiz1, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @mark2 = FactoryGirl.create(:student_quiz, student: @mark, quiz: @quiz2, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @mark3 = FactoryGirl.create(:student_quiz, student: @mark, quiz: @quiz3, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @mark4 = FactoryGirl.create(:student_quiz, student: @mark, quiz: @quiz4, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @mark5 = FactoryGirl.create(:student_quiz, student: @mark, quiz: @quiz5, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @mark6 = FactoryGirl.create(:student_quiz, student: @mark, quiz: @quiz6, num_correct: 4, num_attempts: 4, num_fouls: 0)   

      # student with negative day 
      @jimmy1 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz1, num_correct: 1, num_attempts: 4, num_fouls: 0)
      @jimmy2 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz2, num_correct: 0, num_attempts: 0, num_fouls: 1)
      @jimmy3 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz3, num_correct: 1, num_attempts: 1, num_fouls: 3)
      @jimmy4 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz4, num_correct: 0, num_attempts: 3, num_fouls: 0)
      @jimmy5 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz5, num_correct: 0, num_attempts: 2, num_fouls: 2)
      @jimmy6 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz6, num_correct: 0, num_attempts: 1, num_fouls: 1)
    end

    def create_junior_student_quizzes
      #jonathan
      @jonathan1 = FactoryGirl.create(:student_quiz, student: @jonathan, quiz: @quiz1, num_correct: 1, num_attempts: 4, num_fouls: 0)
      @jonathan2 = FactoryGirl.create(:student_quiz, student: @jonathan, quiz: @quiz2, num_correct: 0, num_attempts: 0, num_fouls: 1)
      @jonathan3 = FactoryGirl.create(:student_quiz, student: @jonathan, quiz: @quiz3, num_correct: 1, num_attempts: 1, num_fouls: 3)
      @jonathan4 = FactoryGirl.create(:student_quiz, student: @jonathan, quiz: @quiz4, num_correct: 0, num_attempts: 3, num_fouls: 0)
      @jonathan5 = FactoryGirl.create(:student_quiz, student: @jonathan, quiz: @quiz5, num_correct: 0, num_attempts: 2, num_fouls: 2)
      @jonathan6 = FactoryGirl.create(:student_quiz, student: @jonathan, quiz: @quiz6, num_correct: 0, num_attempts: 1, num_fouls: 1)
    end

    def delete_junior_student_quizzes
      @jonathan1.delete
      @jonathan2.delete
      @jonathan3.delete
      @jonathan4.delete
      @jonathan5.delete
      @jonathan6.delete
    end

    def create_senior_b_student_quizzes
      @mindy1 = FactoryGirl.create(:student_quiz, student: @mindy, quiz: @quiz1, num_correct: 1, num_attempts: 4, num_fouls: 0)
      @mindy2 = FactoryGirl.create(:student_quiz, student: @mindy, quiz: @quiz2, num_correct: 0, num_attempts: 0, num_fouls: 1)
      @mindy3 = FactoryGirl.create(:student_quiz, student: @mindy, quiz: @quiz3, num_correct: 1, num_attempts: 1, num_fouls: 3)
      @mindy4 = FactoryGirl.create(:student_quiz, student: @mindy, quiz: @quiz4, num_correct: 0, num_attempts: 3, num_fouls: 0)
      @mindy5 = FactoryGirl.create(:student_quiz, student: @mindy, quiz: @quiz5, num_correct: 0, num_attempts: 2, num_fouls: 2)
      @mindy6 = FactoryGirl.create(:student_quiz, student: @mindy, quiz: @quiz6, num_correct: 0, num_attempts: 1, num_fouls: 1)
    end

    def delete_senior_b_student_quizzes
      @mindy1.delete
      @mindy2.delete
      @mindy3.delete
      @mindy4.delete
      @mindy5.delete
      @mindy6.delete
    end


    # not sure if this is needed yet...
    def create_student_quizzes_with_no_score_yet
      create_quizzes_for_future_event
      #the student_quiz fields are nil
      @alex7 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz1f)
      @alex8 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz2f)
      @alex9 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz3f)
      @alex10 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz4f)
      @alex11 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz5f)
      @alex12 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz6f)
    end

    def delete_student_quizzes
      @mark1.delete
      @mark2.delete
      @mark3.delete
      @mark4.delete
      @mark5.delete
      @mark6.delete
      @alex1.delete
      @alex2.delete
      @alex3.delete
      @alex4.delete
      @alex5.delete
      @alex6.delete
      @jimmy1.delete
      @jimmy2.delete
      @jimmy3.delete
      @jimmy4.delete
      @jimmy5.delete
      @jimmy6.delete
    end

    def delete_student_quizzes_with_no_score_yet
      delete_quizzes_for_future_event
      @alex7.delete
      @alex8.delete
      @alex9.delete
      @alex10.delete
      @alex11.delete
      @alex12.delete
    end
  end
end