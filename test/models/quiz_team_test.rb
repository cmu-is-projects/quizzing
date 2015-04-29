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
      create_quiz_teams_for_past_event #(which includes create_acac_quiz_teams_for_past_event)
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
      delete_quiz_teams_for_past_event #(which includes create_acac_quiz_teams_for_past_event)
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
    #TODO: Seek to know why the commented-out below gives Quiz is not active in system error
      create_quiz_teams_for_future_event
      assert_equal 18, QuizTeam.all.size
      assert_equal 6, QuizTeam.for_event(@event3).all.size
      delete_quiz_teams_for_future_event
      assert_equal 12, QuizTeam.all.size
      assert_equal 12, QuizTeam.for_event(@event).all.size
      assert_equal 0, QuizTeam.for_event(@event5).all.size
    end

    should "have class method to get all team quizzes for a team" do
      assert_equal 12, QuizTeam.all.size
      assert_equal 6, QuizTeam.for_team(@acac_sr1).all.size
    end

    should "order team quizzes by round_num" do
      #with only create_quiz_teams_for_past_event (which includes create_acac_quiz_teams_for_past_event) according to context atop
      assert_equal [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6], QuizTeam.by_round_num.map { |qt| qt.quiz.round_num }
    end

    #TODO: test the below with teams (this was copied from student_quiz_test)
    should "accurately retreive the points" do
      assert_equal 20, @quiz1_acac1.retreive_qt_points


      # teams with positive points
      assert_equal 15, @quiz2_acac1.retreive_qt_points
      assert_equal 5, @quiz3_acac1.retreive_qt_points
      assert_equal 14, @quiz4_acac1.retreive_qt_points
      assert_equal 20, @quiz5_acac1.retreive_qt_points
      assert_equal 19, @quiz6_acac1.retreive_qt_points
      assert_equal 1, @quiz6_somerset.retreive_qt_points

      # teams with nil points
      create_quiz_teams_for_future_event
      assert_equal nil, @quiz1f_acac2.retreive_qt_points   # num_correct: 1, num_attempts: 4, num_fouls: 0
      assert_equal nil, @quiz2f_acac2.retreive_qt_points   # num_correct: 0, num_attempts: 0, num_fouls: 1
      assert_equal nil, @quiz3f_acac2.retreive_qt_points  # num_correct: 1, num_attempts: 1, num_fouls: 3
      assert_equal nil, @quiz4f_acac2.retreive_qt_points # num_correct: 0, num_attempts: 3, num_fouls: 0
      assert_equal nil, @quiz5f_acac2.retreive_qt_points # num_correct: 0, num_attempts: 2, num_fouls: 2
      assert_equal nil, @quiz6f_acac2.retreive_qt_points   # num_correct: 0, num_attempts: 1, num_fouls: 1
      delete_quizzes_for_future_event
    end

    should "have class method to get all quiz_teams for an event" do
      create_quiz_teams_for_future_event
      assert_equal 18, QuizTeam.all.size
      assert_equal 6, QuizTeam.for_event(@event3).all.size
      delete_quiz_teams_for_future_event
    end

    should "have class method to get all quiz_teams for a team" do
      assert_equal 12, QuizTeam.all.size
      assert_equal 6, QuizTeam.for_team(@acac_sr1).all.size
    end

  end
end
