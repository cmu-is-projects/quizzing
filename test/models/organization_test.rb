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
  should validate_presence_of(:primary_contact)


  include Contexts::OrganizationContexts
  context "Creating an organization context" do
    setup do 
      create_organizations
    end
    
    teardown do
      delete_organizations
    end

    should "Show that that organization's active scope works" do
    	assert_equal 2, Organization.active.size
    	assert_equal ["Org One", "Org Two"], Organization.active.all.map{|o| o.name}
    end

    should "show that organization's inactive scope works" do
    	assert_equal 1, Organization.inactive.size
    	assert_equal ["Org Inactive"], Organization.inactive.all.map{|o| o.name}
    end

    should "show that organization's alphabetical scope works correctly" do
    	assert_equal ["Org Inactive", "Org One", "Org Two"], Organization.alphabetical.all.map { |o| o.name }
    end

    should "show that def find_coordinates works" do
      assert_in_delta(40.4411659, @org1.latitude, 0.00001)
      assert_in_delta(-79.9421425, @org1.longitude, 0.00001)

    end

  end # contexts
end
