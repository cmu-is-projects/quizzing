require 'test_helper'
#Theophilus wrote this based off Prof H's YearQuizzerTest
class YearTeamTest < ActiveSupport::TestCase
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
    end

    should "provide essential information a view would want to display" do
      create_year_teams
      assert_equal "ACAC JR1", @year_team_1.name
      assert_equal "ACAC 3", @year_team_2.team.name
      assert_equal "Senior A", @year_team_3.division.name
      assert_equal 1, @year_team_1.results.size
      remove_year_teams
    end

    should "calculate total_yt_points for year accurately when only 1 event" do
      create_year_teams
      #go to QuizTeam and add the team's scores
      assert_equal 0, @year_team_1.total_yt_points
      assert_equal 0, @year_team_2.total_yt_points
      assert_equal 93, @year_team_3.total_yt_points
      assert_equal 27, @year_team_4.total_yt_points
      remove_year_teams
    end

    should "return an array of year_teams for a particular division and year" do
      create_quiz_teams_for_future_event #adds ACAC SR2 which is also of Division Senior A, 
      #BUT it has not quizzed this year :)
      assert_equal 2, YearTeam.get_all_teams_for_division_for_year(@senior_a, QuizYear.new).size
      yt = YearTeam.get_all_teams_for_division_for_year(@senior_a, QuizYear.new).first
      assert_equal YearTeam, yt.class
      delete_quiz_teams_for_future_event
    end

  end #end contexts
end #end class