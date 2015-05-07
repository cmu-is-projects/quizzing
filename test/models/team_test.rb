require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:organization)
  should belong_to(:division)
  should have_many(:student_teams)
  should have_many(:students).through(:student_teams)
  should have_many(:team_coaches)
  should have_many(:coaches).through(:team_coaches)

  # test validations
  should validate_presence_of(:division_id)
  should validate_presence_of(:organization_id)
  should validate_presence_of(:name)

  context "Creating a context" do
    setup do
      create_one_organization
      create_divisions
      create_acac_teams
    end

    teardown do
      delete_divisions
      delete_one_organization 
      delete_acac_teams
    end

    should "correctly assess when a team is destroyable" do
      # test when team is associated with quizzes (no)
      create_events
      create_categories
      create_quizzes_for_past_event
      create_acac_quiz_teams_for_past_event
      deny @acac_sr1.scored_quizzes_this_year.empty?
      deny @acac_sr1.destroy # it cannot be destroyed
      @acac_sr1.destroy      # verify
      deny @acac_sr1.destroyed?
      delete_quizzes_for_past_event
      delete_acac_quiz_teams_for_past_event     

      # test when no quizzes for team (yes)
      create_quizzes_for_future_event
      create_quiz_teams_for_future_event
      assert @acac_sr2.scored_quizzes_this_year.empty?
      assert @acac_sr2.destroy
      @acac_sr2.destroy
      assert @acac_sr2.destroyed?
      delete_quizzes_for_future_event
      delete_quiz_teams_for_future_event
      delete_events
      delete_categories
    end

    should "verify that the organization is active in the system" do
      # test the inactive organization first
      grove_city = FactoryGirl.create(:organization, name: "Grove City Church", short_name: "Grove City", active: false)
      bad_team = FactoryGirl.build(:team, division: @senior_a, organization: grove_city, name: "GC 1")
      deny bad_team.valid?
      grove_city.delete
      # test the nonexistent organization
      mars = FactoryGirl.build(:organization, name: "Mars Alliance Church", short_name: "Mars", active: true)
      bad_team = FactoryGirl.build(:team, division: @senior_a, organization: mars, name: "Mars 1")
      deny bad_team.valid?
    end

    should "verify that the division is active in the system" do
      # test the inactive division first
      @senior_b.active = false
      @senior_b.save
      @senior_b.reload

      bad_team = FactoryGirl.build(:team, division: @senior_b, organization: @acac, name: "ACAC B1")
      deny bad_team.valid?, "#{bad_team.valid?} :: #{bad_team.to_yaml} :: Division: #{bad_team.division.active}"

      @senior_b.active = true
      # now reset back to active
      @senior_b.save  
      @senior_b.reload    
      assert @senior_b.active
      
      # test the nonexistent division
      junior_b = FactoryGirl.build(:division, name: "Junior B")
      bad_team = FactoryGirl.build(:team, division: junior_b, organization: @acac, name: "ACAC JB1")
      deny bad_team.valid?
    end

    should "verify that the alphabetical scope works" do
      assert_equal ["ACAC 1","ACAC 2","ACAC 3", "ACAC JR1"], Team.alphabetical.map(&:name)
    end

    should "Show that that the active scope works" do
      assert_equal 3, Team.active.size
      assert_equal ["ACAC 1","ACAC 2","ACAC JR1"], Team.active.all.map(&:name).sort
    end

    should "show that the inactive scope works" do
      assert_equal 1, Team.inactive.size
      assert_equal ["ACAC 3"], Team.inactive.all.map(&:name).sort
    end

    should "have methods to make active or inactive" do
      @acac_sr1.make_inactive
      deny @acac_sr1.active
      @acac_sr1.make_active
      assert @acac_sr1.active
    end

    should "have a method to return students currently on the team" do
      create_students
      create_acac_student_teams
      assert_equal 2, @acac_sr1.current_students.size
      assert_equal %w[Alex Mark], @acac_sr1.current_students.map{|s| s.first_name}.sort
      delete_acac_student_teams
      delete_students
    end

    should "have a scope for getting teams by division" do
      assert_equal "Senior A", @senior_a.name
      assert_equal ["ACAC 1", "ACAC 2", "ACAC 3"], Team.for_division(@senior_a).map(&:name).sort
    end

    should "show that the not_at_capacity method works" do
      assert_equal 3, Team.active.size
      assert_equal 3, Team.not_at_capacity.size
      delete_acac_teams
      assert_equal 0, Team.active.size
      assert_equal Array.new, Team.not_at_capacity
    end
    
  end #contexts
  
end # class
