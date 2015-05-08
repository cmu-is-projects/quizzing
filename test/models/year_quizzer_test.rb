require 'test_helper'

class YearQuizzerTest < ActiveSupport::TestCase
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

    should "provide essential information a view would want to display" do
      create_year_quizzers
      assert_equal "Mark Heimann", @year_quizzer_1.name
      assert_equal "ACAC 1", @year_quizzer_1.team.name
      assert_equal "Senior A", @year_quizzer_1.division.name
      assert_equal 1, @year_quizzer_1.results.size
      remove_year_quizzers
    end

    should "calculate total points for year accurately when only 1 event" do
      create_year_quizzers
      assert_equal 540, @year_quizzer_1.total_points
      assert_equal 300, @year_quizzer_2.total_points
      assert_equal -20, @year_quizzer_3.total_points
      assert_equal   0, @year_quizzer_4.total_points
      remove_year_quizzers
    end

    should "calculate low points for year accurately when only 1 event" do
      create_year_quizzers
      assert_equal '--', @year_quizzer_1.lowest_points
      assert_equal '--', @year_quizzer_2.lowest_points
      assert_equal '--', @year_quizzer_3.lowest_points
      assert_equal '--', @year_quizzer_4.lowest_points     
      remove_year_quizzers 
    end

    should "calculate adjusted points for year accurately when only 1 event" do
      create_year_quizzers
      assert_equal 540, @year_quizzer_1.adjusted_points
      assert_equal 300, @year_quizzer_2.adjusted_points
      assert_equal -20, @year_quizzer_3.adjusted_points
      assert_equal   0, @year_quizzer_4.adjusted_points
      remove_year_quizzers       
    end

    should "calculate total accuracy for year accurately when only 1 event" do
      create_year_quizzers
      assert_equal 1.000, @year_quizzer_1.total_accuracy
      assert_equal 0.696, @year_quizzer_2.total_accuracy
      assert_equal 0.182, @year_quizzer_3.total_accuracy
      assert_equal  0.0,  @year_quizzer_4.total_accuracy
      remove_year_quizzers 
    end

    should "calculate total points for year accurately when 4 events" do
      create_three_more_complete_quiz_contexts
      create_year_quizzers
      assert_equal 4, @year_quizzer_1.results.size
      assert_equal 1620, @year_quizzer_1.total_points, "Results count: #{Event.all.size}"
      assert_equal 1800, @year_quizzer_2.total_points
      assert_equal   70, @year_quizzer_3.total_points
      assert_equal    0, @year_quizzer_4.total_points
      remove_year_quizzers
      delete_three_more_complete_quiz_contexts
    end

    should "calculate low points for year accurately when 4 events" do
      create_three_more_complete_quiz_contexts
      create_year_quizzers
      assert_equal   0, @year_quizzer_1.lowest_points, "Results count: #{@year_quizzer_1.results.size}"
      assert_equal 300, @year_quizzer_2.lowest_points, "Results count: #{@year_quizzer_2.results.size}"
      assert_equal -20, @year_quizzer_3.lowest_points
      assert_equal   0, @year_quizzer_4.lowest_points
      remove_year_quizzers
      delete_three_more_complete_quiz_contexts
    end

    should "calculate adjusted points for year accurately when 4 events" do
      create_three_more_complete_quiz_contexts
      create_year_quizzers
      assert_equal 1620, @year_quizzer_1.adjusted_points, "Results count: #{@year_quizzer_1.results.size}"
      assert_equal 1500, @year_quizzer_2.adjusted_points, "Results count: #{@year_quizzer_2.results.size}"
      assert_equal   90, @year_quizzer_3.adjusted_points
      assert_equal    0, @year_quizzer_4.adjusted_points
      remove_year_quizzers
      delete_three_more_complete_quiz_contexts
    end

    should "calculate total accuracy for year accurately when 4 events" do
      create_three_more_complete_quiz_contexts
      create_year_quizzers
      assert_equal 1.000, @year_quizzer_1.total_accuracy
      assert_equal 0.822, @year_quizzer_2.total_accuracy
      assert_equal 0.348, @year_quizzer_3.total_accuracy
      assert_equal  0.0,  @year_quizzer_4.total_accuracy
      remove_year_quizzers
      delete_three_more_complete_quiz_contexts
    end

    should "return an array of year_quizzers for a particular division and year" do
      assert_equal 3, YearQuizzer.get_all_quizzers_for_division_for_year(@senior_a, QuizYear.new).size
      yq = YearQuizzer.get_all_quizzers_for_division_for_year(@senior_a, QuizYear.new).first
      assert_equal YearQuizzer, yq.class
    end

  end
end