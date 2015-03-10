require 'test_helper'

class OrganizationStudentTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:organization)
  should belong_to(:student)

  context "Creating a context" do
    setup do
      create_organizations
      create_students
      create_organization_students
    end

    teardown do
      delete_organizations
      delete_students
      delete_organization_students
    end

    should "verify that the organization is active in the system" do
      # test the inactive organization first
      bad_org_student = FactoryGirl.build(:organization_student, organization: @grove_city, student: @mark)
      deny bad_org_student.valid?
      # test the nonexistent organization
      mars = FactoryGirl.build(:organization, name: "Mars Alliance Church", short_name: "Mars", active: true)
      bad_org_student = FactoryGirl.build(:organization_student, organization: mars, student: @mark)
      deny bad_org_student.valid?
    end

    should "verify that the student is active in the system" do
      # test the inactive student first
      bad_org_student = FactoryGirl.build(:organization_student, organization: @acac, student: @gone)
      deny bad_org_student.valid?
      # test the nonexistent student
      fred = FactoryGirl.build(:student, first_name: "Fred", active: true)
      bad_org_student = FactoryGirl.build(:organization_student, organization: @acac, student: fred)
      deny bad_org_student.valid?
    end

    should "have a current scope to find current students" do
      assert_equal 7, OrganizationStudent.current.all.size
    end

    should "have a for_organization scope to find students for an organization" do
      assert_equal 5, OrganizationStudent.for_organization(@acac).all.size
      assert_equal 3, OrganizationStudent.for_organization(@somerset).all.size
    end

    should "be able to find current students for a given organization" do
      assert_equal 5, OrganizationStudent.for_organization(@acac).all.size
      assert_equal 4, OrganizationStudent.current.for_organization(@acac).all.size
    end

  end
end
