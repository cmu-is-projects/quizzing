require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # test relationships
  should have_many(:organization_students)
  should have_many(:organizations).through(:organization_students)
  should have_many(:student_teams)
  should have_many(:teams).through(:student_teams)
  should have_many(:student_quizzes)
  should have_many(:quizzes).through(:student_quizzes)

  #test validations
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:grade)
  should validate_numericality_of(:grade).only_integer.is_greater_than(1).is_less_than(13)

  should allow_value("String").for(:first_name)
  should allow_value("String").for(:last_name)
  should allow_value(9).for(:grade)
  should_not allow_value(1).for(:grade)
  should_not allow_value(nil).for(:first_name)
  should_not allow_value(nil).for(:last_name)
  should_not allow_value(nil).for(:grade)
  should_not allow_value("String").for(:grade)

  #set up a context
  context "Creating a Student Context" do
    
    setup do
      create_students
    end

    teardown do
      delete_students
    end

    should "verify that the name method works" do
      assert @mark.name == "Heimann, Mark"
    end
    
    should "verify that the proper_name method works" do
      assert @mark.proper_name == "Mark Heimann"
    end

    should "verify that the alphabetical scope works" do
      assert_equal %w[Cranston Douglas Gone Heimann Heimann Mix Olbeter Olson], Student.alphabetical.map(&:last_name)
    end

    should "Show that that the active scope works" do
      assert_equal 7, Student.active.size
      assert_equal %w[Cranston Douglas Heimann Heimann Mix Olbeter Olson], Student.active.all.map{|a| a.last_name}.sort
    end

    should "show that the inactive scope works" do
      assert_equal 1, Student.inactive.size
      assert_equal ["Gone"], Student.inactive.all.map{|a| a.last_name}.sort
    end

    should "have methods to make active or inactive" do
      @mark.make_inactive
      deny @mark.active
      @mark.make_active
      assert @mark.active
    end

    should "correctly assess that a student is not destroyable" do
      deny @mark.destroy
    end

    should "identify the student's current organization" do
      create_one_organization
      create_acac_students
      assert @acac, @mark.current_organization
      assert_nil @quincy.current_organization
      delete_one_organization
      delete_acac_students      
    end

    should "identify the student's current team" do
      create_one_organization
      create_divisions
      create_acac_students
      create_acac_teams
      create_acac_student_teams
      assert @acac_sr1, @mark.current_team
      assert_not_equal @acac_sr2, @mark.current_team
      assert_nil @quincy.current_team
      delete_one_organization
      delete_divisions
      delete_acac_students
      delete_acac_teams
      delete_acac_student_teams      
    end

  end
end
