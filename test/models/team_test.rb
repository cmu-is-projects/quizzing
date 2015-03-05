require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:organization)
  should belong_to(:division)
  should have_many(:student_teams)
  should have_many(:students).through(:student_teams)
  should have_many(:team_coaches)
  should have_many(:coaches).through(:team_coaches)

  #validations
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name).case_insensitive
  should validate_presence_of(:division_id)
  should validate_presence_of(:organization_id)

  context "Creating a team context" do
    setup do
      create_organizations
      create_divisions
      create_teams
    end
    
    teardown do
      delete_teams
      delete_organizations
      delete_divisions
    end

    should "Show that that team's active scope works" do
      assert_equal 2, Team.active.size
      assert_equal ["Team One", "Team Two"], Team.active.all.map{|t| t.name}.sort
    end

    should "show that team's inactive scope works" do
      assert_equal 1, Team.inactive.size
      assert_equal ["Team Inactive"], Team.inactive.all.map{|t| t.name}.sort
    end

    should "show that team's alphabetical scope works correctly" do
      assert_equal ["Team Inactive", "Team One", "Team Two"], Team.alphabetical.all.map { |t| t.name }
    end

    # should "verify that the team's organization is active in the system" do
    #   inactive_organization = FactoryGirl.build(:organization, active: false)
    #   division = FactoryGirl.build(:division, name: "Generic Division")
    #   invalid_team = FactoryGirl.build(:team, organization: @inactive_organization, division: @division)
    #   deny invalid_team.valid?
    # end


  end #context


end #class
