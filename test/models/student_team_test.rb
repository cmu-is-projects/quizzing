require 'test_helper'

class StudentTeamTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:student)
  should belong_to(:team)

  # matchers for validation tests
  should validate_presence_of(:student_id)
  should validate_presence_of(:team_id)

  context "Creating a context" do
    setup do
      create_one_organization
      create_divisions
      create_students
      create_acac_teams
      create_acac_student_teams
    end

    teardown do
      delete_one_organization
      delete_divisions
      delete_students
      delete_acac_teams
      delete_acac_student_teams
    end

    should "verify that the team is active in the system" do
      # test the inactive team first
      bad_student_team = FactoryGirl.build(:student_team, team: @acac_sr3, student: @mark)
      deny bad_student_team.valid?
      # test the nonexistent team
      acac_sr4 = FactoryGirl.build(:team, division: @senior_a, organization: @acac, name: "ACAC 4", active: true)
      bad_student_team = FactoryGirl.build(:student_team, team: acac_sr4, student: @mark)
      deny bad_student_team.valid?
    end

    should "verify that the student is active in the system" do
      # test the inactive student first
      fred = FactoryGirl.create(:student, first_name: "Fred", active: false)
      bad_student_team = FactoryGirl.build(:student_team, team: @acac_sr1, student: fred)
      deny bad_student_team.valid?
      fred.delete
      # test the nonexistent student
      ned = FactoryGirl.build(:student, first_name: "Ned", active: true)
      bad_student_team = FactoryGirl.build(:student_team, team: @acac_sr1, student: ned)
      deny bad_student_team.valid?
    end

    should "have scope to find all captains" do
      assert_equal 5, StudentTeam.all.size
      assert_equal 2, StudentTeam.is_captain.all.size
    end

    should "have scope to find all current assignments" do
      assert_equal 5, StudentTeam.all.size
      assert_equal 4, StudentTeam.current.all.size
    end

    should "have methods to make active or inactive" do
      @mark_acac_sr1.make_inactive
      deny @mark_acac_sr1.active
      @mark_acac_sr1.make_active
      assert @mark_acac_sr1.active
    end

    should "Show that that the active scope works" do
      assert_equal 5, StudentTeam.all.size
      @mark_acac_sr1.make_inactive
      assert_equal 4, StudentTeam.active.size
    end

    should "show that the inactive scope works" do
      assert_equal 5, StudentTeam.all.size
      @mark_acac_sr1.make_inactive
      @alex_acac_sr1.make_inactive
      assert_equal 2, StudentTeam.inactive.size
    end

    should "end previous assignment before adding to new team" do
      assert @acac_sr1, @mark.current_team
      assert_not_equal @acac_sr2, @mark.current_team
      @mark_acac_sr2 = FactoryGirl.create(:student_team, student: @mark, team: @acac_sr2, is_captain: false)
      @mark.reload
      assert_not_equal @acac_sr1, @mark.current_team
      assert @acac_sr2, @mark.current_team
    end

    should "have scope to filter student_teams for a particular day" do
      assert_equal 5, StudentTeam.all.size
      assert_equal 2, StudentTeam.for_date(35.months.ago.to_date).size
      assert_equal 3, StudentTeam.for_date(30.months.ago.to_date).size
      assert_equal 4, StudentTeam.for_date(2.years.ago.to_date).size
      assert_equal 3, StudentTeam.for_date(1.year.ago.to_date).size
      assert_equal 0, StudentTeam.for_date(5.years.ago.to_date).size
      assert_equal 4, StudentTeam.for_date(Date.today).size
    end

  end
end
