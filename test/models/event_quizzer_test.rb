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
      @event_quizzer_4 = EventQuizzer.new(@jonathan, @event)
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
      @event_quizzer_4 = nil
    end

    should "provide essential information a view would want to display" do
      assert_equal "Mark Heimann", @event_quizzer_1.name
      assert_equal "ACAC 1", @event_quizzer_1.team.name
      assert_equal "Allegheny Center Alliance Church", @event_quizzer_1.event_host
    end

    should "get all quizzes for a student in this event" do
      #How Prof H had it written
      quizzes = @event_quizzer_1.get_all_student_quizzes_for_student_in_this_event
      assert_equal 6, quizzes.size
      assert_equal 540, quizzes.inject(0){|sum, quiz| sum += quiz.score}
    end

    should "correctly calculate total points" do
      assert_equal 540, @event_quizzer_1.total_points
      assert_equal 300, @event_quizzer_2.total_points
      assert_equal -20, @event_quizzer_3.total_points
      assert_equal   0, @event_quizzer_4.total_points
    end

    should "correctly calculate average points" do
      assert_equal 90.00, @event_quizzer_1.average_points
      assert_equal 50.00, @event_quizzer_2.average_points
      assert_equal -3.33, @event_quizzer_3.average_points
      assert_equal  0.0,  @event_quizzer_4.average_points      
    end
    
    should "correctly calculate accuracy rate" do
      assert_equal 1.000, @event_quizzer_1.accuracy
      assert_equal 0.696, @event_quizzer_2.accuracy
      assert_equal 0.182, @event_quizzer_3.accuracy
      assert_equal  0.0,  @event_quizzer_4.accuracy 
    end

    should "be able to get event quizzers for event sorted by average pts" do
      event_quizzers = EventQuizzer.get_all_quizzers_for_event(@event)
      assert_equal 3, event_quizzers.size
      assert_equal "Mark Heimann", event_quizzers.first.name
    end

    should "be able to get event quizzers for event and division" do
      sra = EventQuizzer.get_all_quizzers_for_event_and_division(@event, @senior_a)
      jr = EventQuizzer.get_all_quizzers_for_event_and_division(@event, @junior)
      assert_equal 3, sra.size
      assert_equal 0, jr.size
      assert_equal "Mark Heimann", sra.first.name
    end

  end
end