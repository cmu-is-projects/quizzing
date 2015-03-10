module Contexts
  module StudentQuizContexts

    # assumes create_students, create_one_event (and related) already run
    def create_student_quizzes
      # student with perfect day
      @mark1 = FactoryGirl.create(:student_quiz, student: @mark, quiz: @quiz1, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @mark2 = FactoryGirl.create(:student_quiz, student: @mark, quiz: @quiz2, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @mark3 = FactoryGirl.create(:student_quiz, student: @mark, quiz: @quiz3, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @mark4 = FactoryGirl.create(:student_quiz, student: @mark, quiz: @quiz4, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @mark5 = FactoryGirl.create(:student_quiz, student: @mark, quiz: @quiz5, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @mark6 = FactoryGirl.create(:student_quiz, student: @mark, quiz: @quiz6, num_correct: 4, num_attempts: 4, num_fouls: 0)

      # student with average day 
      @alex1 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz1, num_correct: 4, num_attempts: 4, num_fouls: 0)
      @alex2 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz2, num_correct: 4, num_attempts: 5, num_fouls: 0)
      @alex3 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz3, num_correct: 3, num_attempts: 5, num_fouls: 0)
      @alex4 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz4, num_correct: 2, num_attempts: 5, num_fouls: 0)
      @alex5 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz5, num_correct: 3, num_attempts: 3, num_fouls: 0)
      @alex6 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz6, num_correct: 0, num_attempts: 1, num_fouls: 0)
   
      # student with negative day 
      @jimmy1 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz1, num_correct: 1, num_attempts: 4, num_fouls: 0)
      @jimmy2 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz2, num_correct: 0, num_attempts: 0, num_fouls: 1)
      @jimmy3 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz3, num_correct: 1, num_attempts: 1, num_fouls: 3)
      @jimmy4 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz4, num_correct: 0, num_attempts: 3, num_fouls: 0)
      @jimmy5 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz5, num_correct: 0, num_attempts: 2, num_fouls: 2)
      @jimmy6 = FactoryGirl.create(:student_quiz, student: @jimmy, quiz: @quiz6, num_correct: 0, num_attempts: 1, num_fouls: 1)
    end

    # not sure if this is needed yet...
    def create_student_quizzes_with_no_score_yet
      @alex1 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz1f)
      @alex2 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz2f)
      @alex3 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz3f)
      @alex4 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz4f)
      @alex5 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz5f)
      @alex6 = FactoryGirl.create(:student_quiz, student: @alex, quiz: @quiz6f)
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
      @alex1.delete
      @alex2.delete
      @alex3.delete
      @alex4.delete
      @alex5.delete
      @alex6.delete
    end
  end
end