require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  # test relationships
  should have_many(:organization_students)
  should have_many(:students).through(:organization_students)
  should have_many(:coaches)
  should have_many(:teams)
  should have_many(:events)

  # Validations
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name).case_insensitive
  should validate_presence_of(:primary_contact)
  #will next turn the below two into dependent conditionals 
  #should validate_presence_of(:street_1)
  #should validate_presence_of(:zip)
  should allow_value("03431").for(:zip)
  should allow_value("15217").for(:zip)
  should allow_value("15090").for(:zip)

  should_not allow_value("3431").for(:zip)
  should_not allow_value("152179").for(:zip)
  should_not allow_value("profh").for(:zip)

  should allow_value("PA").for(:state)
  should allow_value("WV").for(:state)
  should allow_value("OH").for(:state)
  should allow_value("CA").for(:state)
  should_not allow_value("bad").for(:state)
  should_not allow_value(10).for(:state)
  
  should allow_value(8).for(:primary_contact)
  should allow_value(100).for(:primary_contact)
  should allow_value(28).for(:primary_contact)
  should_not allow_value(0).for(:primary_contact)
  should_not allow_value(-1).for(:primary_contact)
  should_not allow_value(50.5).for(:primary_contact)
  should_not allow_value("bad").for(:primary_contact)


  context "Creating an organization context" do
    setup do 
      create_organizations
    end
    
    teardown do
      delete_organizations
    end

    should "Show that that organization's active scope works" do
    	assert_equal 2, Organization.active.size
    	assert_equal ["Organization One", "Organization Two"], Organization.active.all.map{|o| o.name}
    end

    should "show that organization's inactive scope works" do
    	assert_equal 1, Organization.inactive.size
    	assert_equal ["Organization Inactive"], Organization.inactive.all.map{|o| o.name}
    end

    should "show that organization's alphabetical scope works correctly" do
    	assert_equal ["Organization Inactive", "Organization One", "Organization Two"], Organization.alphabetical.all.map { |o| o.name }
    end

    should "show that def find_coordinates works" do
      assert_in_delta(40.4411659, @organization1.latitude, 0.00001)
      assert_in_delta(-79.9421425, @organization1.longitude, 0.00001)
    end

    #unsure of if need and how to actually code
    # should "verify that an organization's primary_contact is active in the system" do
    #   @inactive_contact = FactoryGirl.create(:coach, organization: @organization1, user: @user1, active: false)
    #   invalid_organization = FactoryGirl.build(:organization, primary_contact: @inactive_contact.id)
    #   deny invalid_team.valid?
    #   @inactive_contact.delete
    # end

  end # contexts
end
