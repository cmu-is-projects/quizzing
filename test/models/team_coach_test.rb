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
  		delete_users
  		delete_divisions
  		delete_organizations
  	end

  	should "verify that coach is active in the system" do
  		bad_team_coach = FactoryGirl.build(:team_coach, coach: @coach_inactive, team: @team1)
  		deny bad_team_coach.valid?, "#{bad_team_coach.to_yaml}"
  	end

  	should "verify that team is active in the system" do
  		bad_team = FactoryGirl.build(:team_coach, coach: @coach1, team: @team3)
  		deny bad_team.valid?
  	end
end
end