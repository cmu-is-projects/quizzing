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
      @event_team_1 = EventTeam.new(@acac_jr1, @event)
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
      assert_equal "ACAC JR1", @event_team_1.name #team's name
      assert_equal ["Jonathan Cranston"], @event_team_1.students.map(&:proper_name)
    end

  end
end