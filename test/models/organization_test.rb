require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  # test relationships
  should have_many(:organization_students)
  should have_many(:students).through(:organization_students)
  should have_many(:coaches)
  should have_many(:teams)

  # Validations



  set up context
  include Contexts
  context "Creating an organization context" do
    setup do 
      create_organizations
    end
    
    teardown do
      destroy_organizations
    end

    should "Show that that organization's active scope works" do
    	assert_equal 2, Organization.active.size
    	assert_equal ["Org One", "Org Two"], Organization.active.all.map{|a| a.name}
    end

    should "show that organization's inactive scope works" do
    	assert_equal 1, Organization.inactive.size
    	assert_equal ["Org Inactive"], Organization.inactive.all.map{|a| a.name}
    end

    should "show that organization's alphabetical scope works correctly" do
    	assert_equal ["Org Inactive", "Org One", "Org Two"], Organization.alphabetical.all.map { |a| a.name }
    end

    # should "show that def find_coordinates works" do
    #   assert_in_delta(20.8365072, @juvadi.latitude, 0.00001)
    #   assert_in_delta(78.7093556, @juvadi.longitude, 0.00001)
    # end

  end # contexts
end
