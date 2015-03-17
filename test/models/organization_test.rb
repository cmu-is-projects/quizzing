require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  # test relationships
  should have_many(:organization_students)
  should have_many(:students).through(:organization_students)
  should have_many(:coaches)
  should have_many(:teams)
  should have_many(:events)
  should belong_to(:primary_contact)

  # Validations
  should validate_presence_of(:name)
  # TODO: Zip / Postal codes issues TBD later
  # should allow_value("12345").for(:zip)
  # should allow_value("12345-0001").for(:zip)
  # should allow_value("03431").for(:zip)
  # should allow_value(nil).for(:zip)
  # should_not allow_value("1234").for(:zip)
  # should_not allow_value("123456").for(:zip)
  # should_not allow_value("12345-001").for(:zip)
  # should_not allow_value("1234I").for(:zip)

  # should_not allow_value("3431").for(:zip)
  # should_not allow_value("152179").for(:zip)
  # should_not allow_value("profh").for(:zip)

  # should allow_value("PA").for(:state)
  # should allow_value("WV").for(:state)
  # should allow_value("OH").for(:state)
  # should allow_value("CA").for(:state)
  # should_not allow_value("bad").for(:state)
  # should_not allow_value(10).for(:state)
  
  # should allow_value(8).for(:primary_contact)
  # should allow_value(100).for(:primary_contact)
  # should allow_value(28).for(:primary_contact)
  # should_not allow_value(0).for(:primary_contact)
  # should_not allow_value(-1).for(:primary_contact)
  # should_not allow_value(50.5).for(:primary_contact)
  # should_not allow_value("bad").for(:primary_contact)

  # set up context

  context "Creating an organization context" do
    setup do 
      create_organizations
    end
    
    teardown do
      delete_organizations
    end

    should "Show that that organization's active scope works" do
    	assert_equal 2, Organization.active.size
    	assert_equal ["ACAC", "Somerset"], Organization.active.all.map{|a| a.short_name}.sort
    end

    should "show that organization's inactive scope works" do
    	assert_equal 1, Organization.inactive.size
    	assert_equal ["Grove City"], Organization.inactive.all.map{|a| a.short_name}.sort
    end

    should "show that organization's alphabetical scope works correctly" do
    	assert_equal ["ACAC", "Grove City", "Somerset"], Organization.alphabetical.all.map { |a| a.short_name }
    end

    should "properly identify the coordinates of the organizations" do
      assert_in_delta(40.4533665, @acac.latitude, 0.0001)
      assert_in_delta(-80.0030653, @acac.longitude, 0.0001)
    end

    should "have methods to make active or inactive" do
      @acac.make_inactive
      deny @acac.active
      @acac.make_active
      assert @acac.active
    end

    should "correctly assess that an organization is not destroyable" do
      deny @acac.destroy
    end

    should "remove students from an inactive organization" do
      create_students
      create_organization_students
      deny @acac.organization_students.current.empty? 
      @acac.make_inactive
      @acac.reload
      assert @acac.organization_students.current.empty?
      delete_students
      delete_organization_students
    end

    should "have method to find current students in organization" do
      create_students
      create_organization_students
      assert_equal 4, @acac.current_students.size
      assert_equal %w[Alex Amanda Jonathan Mark], @acac.current_students.map{|s| s.first_name}.sort
      delete_students
      delete_organization_students
    end

  end # contexts
end
