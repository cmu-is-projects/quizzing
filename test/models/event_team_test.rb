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
      @event_team = EventTeam.new(@acac_sr1, @event)
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
      @event_team = nil
  	end

    should "provide essential information a view would want to display" do
      assert_equal "ACAC 1", @event_team.name #team's name
      assert_equal ["Alex", "Mark", "Quincy"], @event_team.students.alphabetical.map(&:first_name)
    end

    should "correctly calculate total score" do
      assert_equal 93, @event_team.total_et_points
    end

    should "get all team quizzes for a team in this event" do
      #top down design assuming method written
      quiz_teams = @event_team.get_all_quiz_teams_for_team_in_this_event
      assert_equal 6, quiz_teams.size
      assert_equal 93, quiz_teams.inject(0){|sum, qt| sum += qt.raw_score}
    end


  end
end