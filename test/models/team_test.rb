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
  should validate_presence_of(:division_id)
  should validate_presence_of(:organization_id)

  include Contexts::TeamContexts
  context "Creating a team context" do
    setup do 
      create_teams
    end
    
    teardown do
      delete_teams
    end

    should "Show that that team's active scope works" do
      assert_equal 2, Team.active.size
      assert_equal ["Team One", "Team Two"], Team.active.all.map{|t| t.name}
    end

    should "show that team's inactive scope works" do
      assert_equal 1, Team.inactive.size
      assert_equal ["Team Inactive"], Team.inactive.all.map{|t| t.name}
    end

    should "show that team's alphabetical scope works correctly" do
      assert_equal ["Team Inactive", "Team One", "Team Two"], Team.alphabetical.all.map { |t| t.name }
    end

  end #context


end #class
