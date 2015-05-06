require 'test_helper'

class StudentQuizTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:student)
  should belong_to(:quiz)

  context "Creating a context" do
    setup do
      create_organizations
      create_divisions
      create_categories
      create_events
      create_quizzes_for_past_event
      create_students
      create_organization_students
      create_teams
      create_student_teams
      create_quiz_teams_for_past_event
      create_student_quizzes
    end

    teardown do
      delete_organizations
      delete_divisions
      delete_categories
      delete_events
      delete_quizzes_for_past_event
      delete_students
      delete_organization_students
      delete_teams
      delete_student_teams
      delete_quiz_teams_for_past_event
      delete_student_quizzes
    end

    should "verify that the student is active in the system" do
      # test the inactive student first
      bad_student_quiz = FactoryGirl.build(:student_quiz, quiz: @quiz1, student: @gone)
      deny bad_student_quiz.valid?
      # test the nonexistent student
      fred = FactoryGirl.build(:student, first_name: "Fred", active: true)
      bad_student_quiz = FactoryGirl.build(:student_quiz, quiz: @quiz1, student: fred)
      deny bad_student_quiz.valid?
    end

    should "verify that the quiz is active in the system" do
      # test the inactive quiz first
      bad_student_quiz = FactoryGirl.build(:student_quiz, quiz: @quiz_inactive, student: @mark)
      deny bad_student_quiz.valid?
      # test the nonexistent quiz
      quiz7 = FactoryGirl.build(:quiz, event: @event, division: @senior_a, round_num: 7, category: @category1)
      bad_student_quiz = FactoryGirl.build(:student_quiz, quiz: quiz7, student: @mark)
      deny bad_student_quiz.valid?
    end

    should "accurately calculate the score" do
      assert_equal 90, @mark1.calculate_score # num_correct: 4, num_attempts: 4, num_fouls: 0

      # student with average day 
      assert_equal 90, @alex1.calculate_score # num_correct: 4, num_attempts: 4, num_fouls: 0
      assert_equal 80, @alex2.calculate_score # num_correct: 4, num_attempts: 5, num_fouls: 0
      assert_equal 50, @alex3.calculate_score # num_correct: 3, num_attempts: 5, num_fouls: 0
      assert_equal 20, @alex4.calculate_score # num_correct: 2, num_attempts: 5, num_fouls: 0
      assert_equal 60, @alex5.calculate_score # num_correct: 3, num_attempts: 3, num_fouls: 0
      assert_equal 0, @alex6.calculate_score  # num_correct: 0, num_attempts: 1, num_fouls: 0

      # student with negative day 
      assert_equal 0, @jimmy1.calculate_score   # num_correct: 1, num_attempts: 4, num_fouls: 0
      assert_equal 0, @jimmy2.calculate_score   # num_correct: 0, num_attempts: 0, num_fouls: 1
      assert_equal 10, @jimmy3.calculate_score  # num_correct: 1, num_attempts: 1, num_fouls: 3
      assert_equal -20, @jimmy4.calculate_score # num_correct: 0, num_attempts: 3, num_fouls: 0
      assert_equal -10, @jimmy5.calculate_score # num_correct: 0, num_attempts: 2, num_fouls: 2
      assert_equal 0, @jimmy6.calculate_score   # num_correct: 0, num_attempts: 1, num_fouls: 1

      # students with nil scores
      
      create_student_quizzes_with_no_score_yet
      assert_equal nil, @alex7.calculate_score
      assert_equal nil, @alex8.calculate_score
      
      delete_student_quizzes_with_no_score_yet
    end

    should "have scores calculated upon either create or edit" do
      assert_equal 90, @mark1.score # was calculated when created
      @mark1.num_attempts = 5
      @mark1.save
      @mark1.reload
      assert_equal 80, @mark1.score # was recalculated when revised
    end

    should "have class method to get all student_quizzes for an event" do
      
      create_student_quizzes_with_no_score_yet
      assert_equal 24, StudentQuiz.all.size
      assert_equal 18, StudentQuiz.for_event(@event).all.size
      delete_student_quizzes_with_no_score_yet
      
    end

    should "have class method to get all student_quizzes for a student" do
      assert_equal 18, StudentQuiz.all.size
      assert_equal 6, StudentQuiz.for_student(@mark).all.size
    end

    should "order student_quizzes by round_num" do
      #When refactoring, scrap this and use Ruby's sort
      #according to create_student_quizzes according to above
      assert_equal [1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6], StudentQuiz.by_round_num.map { |sq| sq.quiz.round_num }
    end

  end

end
