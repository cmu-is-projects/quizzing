require 'test_helper'

class EventTeamTest < ActiveSupport::TestCase
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
      @event_team_1 = EventTeam.new(@acac_sr1, @event)
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
      @event_team_1 = nil
  	end

    should "provide essential information a view would want to display" do
      assert_equal "ACAC 1", @event_team_1.name #team's name
      assert_equal ["Alex", "Mark", "Quincy"], @event_team_1.students.alphabetical.map(&:first_name)
    end

    should "get all team quizzes for a team in this event" do
      #top down design assuming method written
      team_quizzes = @event_team_1.get_all_team_quizzes_for_team_in_this_event
      assert_equal 6, team_quizzes.size
      assert_equal 93, team_quizzes.inject(0){|sum, quiz| sum += quiz.score}
    end


  end
end