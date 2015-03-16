require 'test_helper'

class TeamCoachTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:team)
  should belong_to(:coach)


  context "Creating a context" do
    setup do
      create_one_organization
      create_divisions
      create_users
      create_coaches
      create_acac_teams
      create_team_coaches
    end

    teardown do
      delete_one_organization
      delete_divisions
      delete_users
      delete_coaches
      delete_acac_teams
      delete_team_coaches
    end

    should "verify that the team is active in the system" do
      # test the inactive team first
      bad_team_coach = FactoryGirl.build(:team_coach, coach: @coach1, team: @acac_sr3)
      deny bad_team_coach.valid?
      # test the nonexistent team
      acac_sr4 = FactoryGirl.build(:team, division: @senior_a, organization: @acac, name: "ACAC 4")
      bad_team_coach = FactoryGirl.build(:team_coach, coach: @coach1, team: acac_sr4)
      deny bad_team_coach.valid?
    end

    should "verify that the coach is active in the system" do
      # test the inactive coach first
      bad_team_coach = FactoryGirl.build(:team_coach, coach: @coach_inactive, team: @acac_sr1)
      deny bad_team_coach.valid?
      # test the nonexistent coach
      coach_ghost = FactoryGirl.build(:coach, organization: @acac, user: @user3)
      bad_team_coach = FactoryGirl.build(:team_coach, coach: coach_ghost, team: @acac_sr1)
      deny bad_team_coach.valid?
    end

  end

end

