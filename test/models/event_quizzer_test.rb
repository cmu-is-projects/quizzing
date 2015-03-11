require 'test_helper'

class EventQuizzerTest < ActiveSupport::TestCase
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
      create_student_quizzes
      @event_quizzer_1 = EventQuizzer.new(@mark, @event)
      @event_quizzer_2 = EventQuizzer.new(@alex, @event)
      @event_quizzer_3 = EventQuizzer.new(@jimmy, @event)
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
      delete_student_quizzes
      @event_quizzer_1 = nil
      @event_quizzer_2 = nil
      @event_quizzer_3 = nil
    end

    should "get all quizzes for a student in this event" do
      quizzes = @event_quizzer_1.get_all_quizzes_for_student_in_this_event
      assert_equal 6, quizzes.size
      assert_equal 540, quizzes.inject(0){|sum, quiz| sum += quiz.score}
    end

    should "correctly calculate total points" do
      assert_equal 540, @event_quizzer_1.total_points
      assert_equal 300, @event_quizzer_2.total_points
      assert_equal -20, @event_quizzer_3.total_points
    end

    should "correctly calculate average points" do
      assert_equal 90.00, @event_quizzer_1.average_points
      assert_equal 50.00, @event_quizzer_2.average_points
      assert_equal -3.33, @event_quizzer_3.average_points      
    end
    
    should "correctly calculate accuracy rate" do
      assert_equal 1.000, @event_quizzer_1.accuracy
      assert_equal 0.696, @event_quizzer_2.accuracy
      assert_equal 0.182, @event_quizzer_3.accuracy
    end

  end
end