require 'test_helper'

class QuizTeamTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:quiz)
  should belong_to(:team)

  context "Creating a context" do
    setup do
      create_organizations
      create_divisions
      create_events
      create_quizzes_for_past_event
      create_students
      create_organization_students
      create_teams
      create_student_teams
      create_quiz_teams_for_past_event
    end

    teardown do
      delete_organizations
      delete_divisions
      delete_events
      delete_quizzes_for_past_event
      delete_students
      delete_organization_students
      delete_teams
      delete_student_teams
      delete_quiz_teams_for_past_event
    end

    should "verify that the team is active in the system" do
      # test the inactive team first
      bad_quiz_team = FactoryGirl.build(:quiz_team, quiz: @quiz1, team: @acac_sr3)
      deny bad_quiz_team.valid?
      # test the nonexistent team
      acac_sr4 = FactoryGirl.build(:team, division: @senior_a, organization: @acac, name: "ACAC 4")
      bad_quiz_team = FactoryGirl.build(:quiz_team, quiz: @quiz1, team: acac_sr4)
      deny bad_quiz_team.valid?
    end

    should "verify that the quiz is active in the system" do
      # test the inactive quiz first
      bad_quiz_team = FactoryGirl.build(:quiz_team, quiz: @quiz_inactive, team: @acac_sr1)
      deny bad_quiz_team.valid?
      # test the nonexistent quiz
      quiz7 = FactoryGirl.build(:quiz, event: @event, division: @senior_a, round_num: 7)
      bad_quiz_team = FactoryGirl.build(:quiz_team, quiz: quiz7, team: @acac_sr1)
      deny bad_quiz_team.valid?
    end

    should "have class method to get all team_quizzes for an event" do
      create_quizzes_for_future_event
      create_student_quizzes_with_no_score_yet
      assert_equal 24, StudentQuiz.all.size
      assert_equal 18, StudentQuiz.for_event(@event).all.size
      delete_student_quizzes_with_no_score_yet
      delete_quizzes_for_future_event
    end

    should "have class method to get all student_quizzes for a student" do
      assert_equal 18, StudentQuiz.all.size
      assert_equal 6, StudentQuiz.for_student(@mark).all.size
    end

    should "order student_quizzes by round_num" do
      assert_equal [1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6], QuizTeam.by_round_num.map { |qt| qt.quiz.round_num }
    end

  end
end
