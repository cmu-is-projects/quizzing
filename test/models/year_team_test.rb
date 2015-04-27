require 'test_helper'
#Theophilus wrote this based off Prof H's YearQuizzerTest
class YearTeamTest < ActiveSupport::TestCase
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

    should "provide essential information a view would want to display" do
      create_year_teams
      assert_equal "ACAC JR1", @year_team_1.name
      assert_equal "ACAC 3", @year_team_2.team.name
      assert_equal "Senior A", @year_team_3.division.name
      assert_equal 1, @year_team_1.results.size
      remove_year_teams
    end

    should "calculate total_yt_score for year accurately when only 1 event" do
      create_year_teams
      #go to QuizTeam and add the team's scores
      assert_equal 0, @year_team_1.total_yt_score
      assert_equal 0, @year_team_2.total_yt_score
      assert_equal 920, @year_team_3.total_yt_score
      assert_equal 300, @year_team_4.total_yt_score
      remove_year_teams
    end

    # should "calculate total_yt_score for year accurately when 4 events" do
    #   create_three_more_complete_quiz_contexts
    #   create_year_teams
    #   assert_equal 4, @year_team_1.results.size
    #   assert_equal 1620, @year_team_1.total_yt_score, "Results count: #{Event.all.size}"
    #   assert_equal 1800, @year_team_2.total_yt_score
    #   assert_equal   70, @year_team_3.total_yt_score
    #   assert_equal    0, @year_team_4.total_yt_score
    #   remove_year_teams
    #   delete_three_more_complete_quiz_contexts
    # end

    # should "calculate low points for year accurately when 4 events" do
    #   create_three_more_complete_quiz_contexts
    #   create_year_teams
    #   assert_equal   0, @year_team_1.lowest_points, "Results count: #{@year_team_1.results.size}"
    #   assert_equal 300, @year_team_2.lowest_points, "Results count: #{@year_team_2.results.size}"
    #   assert_equal -20, @year_team_3.lowest_points
    #   assert_equal   0, @year_team_4.lowest_points
    #   remove_year_teams
    #   delete_three_more_complete_quiz_contexts
    # end

    # should "calculate adjusted points for year accurately when 4 events" do
    #   create_three_more_complete_quiz_contexts
    #   create_year_teams
    #   assert_equal 1620, @year_team_1.adjusted_points, "Results count: #{@year_team_1.results.size}"
    #   assert_equal 1500, @year_team_2.adjusted_points, "Results count: #{@year_team_2.results.size}"
    #   assert_equal   90, @year_team_3.adjusted_points
    #   assert_equal    0, @year_team_4.adjusted_points
    #   remove_year_teams
    #   delete_three_more_complete_quiz_contexts
    # end

    # should "calculate total accuracy for year accurately when 4 events" do
    #   create_three_more_complete_quiz_contexts
    #   create_year_teams
    #   assert_equal 1.000, @year_team_1.total_accuracy
    #   assert_equal 0.822, @year_team_2.total_accuracy
    #   assert_equal 0.348, @year_team_3.total_accuracy
    #   assert_equal  0.0,  @year_team_4.total_accuracy
    #   remove_year_teams
    #   delete_three_more_complete_quiz_contexts
    # end

    # should "return an array of year_teams for a particular division and year" do
    #   assert_equal 3, YearTeam.get_all_teams_for_division_for_year(@senior_a, QuizYear.new).size
    #   yq = YearTeam.get_all_teams_for_division_for_year(@senior_a, QuizYear.new).first
    #   assert_equal YearTeam, yq.class
    # end

  end #end contexts
end #end class