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

  should allow_value("String").for(:first_name)
  should allow_value("String").for(:last_name)
  should allow_value(9).for(:grade)
  should_not allow_value(1).for(:grade)
  should_not allow_value(nil).for(:first_name)
  should_not allow_value(nil).for(:last_name)
  should_not allow_value(nil).for(:grade)
  should_not allow_value("String").for(:grade)

  #set up a context
  include Contexts::StudentContexts
  context "Creating a Student Context" do
    
    setup do
      create_students
    end

    teardown do
      delete_students
    end

    should "verify that the alphabetical scope works" do
      assert Student.alphabetical.map(&:first_name) == ["Long","Jane","John"]
    end

    should "verify that the active scope works" do
      assert Student.active.alphabetical.map(&:first_name) == ["Jane","John"]
    end

    should "verify that the inactive scope works" do
      assert Student.inactive.alphabetical.map(&:first_name) == ["Long"]
    end

    should "verify that the name method works" do
      assert @stud1.name == "Smith, John"
      assert @stud2.name == "Smith, Jane"
      assert @stud3.name == "Gone, Long"
    end
    
    should "verify that the proper_name method works" do
      assert @stud1.proper_name == "John Smith"
      assert @stud2.proper_name == "Jane Smith"
      assert @stud3.proper_name == "Long Gone"
    end

  end
end
