require 'test_helper'

class TeamCoachTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:team)
  should belong_to(:coach)

  context "Creating a Team Coach context" do
  	setup do
  		create_organizations
  		create_divisions
  		create_users
  		create_coaches
  		create_teams
  	end

  	teardown do
  		delete_teams
  		delete_coaches
  		delete_organizations
  		delete_divisions
  		delete_users
  	end

  	should "verify that coach is active in the system" do
  		bad_coach = FactoryGirl.build(:team_coach, coach: @coach_inactive, team: @team1)
  		deny bad_coach.valid?
  	end
end
end