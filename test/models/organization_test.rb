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
  should allow_value("PA").for(:state)
  should allow_value("WV").for(:state)
  should allow_value("OH").for(:state)
  should allow_value("CA").for(:state)
  should allow_value("Texas").for(:state)
  should_not allow_value("bad").for(:state)
  should_not allow_value(10).for(:state)


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

    should "show that a US state must have an exactly 5 digit zip" do
      bad_org = FactoryGirl.build(:organization, name: "bad org", short_name: "bo", zip: "123456")
      deny bad_org.valid?
      good_org = FactoryGirl.build(:organization, name: "generic org", short_name: "go")
      assert good_org.valid?
    end

    should "show that conditional zip and street_1 is working" do
      #state is provided in Factory, so zip will be 5 digit American format here
      #testing validations cases 1 and 2
      street_1_and_zip = FactoryGirl.build(:organization, name: "s&z", street_1: "1 st", zip: "15213")
      assert street_1_and_zip.valid?
      street_1_wo_zip = FactoryGirl.build(:organization, name: "org", street_1: "1 street", zip: nil)
      deny street_1_wo_zip.valid?
      zip_wo_street_1 = FactoryGirl.build(:organization, name: "org", street_1: nil, zip: "12345")
      deny zip_wo_street_1.valid?
    end

    should "indirectly test zip_and_state_entered? private method" do
      generic_org = FactoryGirl.build(:organization, name: "generic org", short_name: "go")
      assert ( !generic_org.zip.nil? && !generic_org.state.nil? )
    end

    should "indirectly test zip_is_entered_without_a_state? private method" do
      generic_org = FactoryGirl.build(:organization, name: "generic org", short_name: "go", state: nil)
      assert ( !generic_org.zip.nil? && generic_org.state.nil? )
    end

    should "show that it is ok to enter a state with no zip AND no street_1" do
      generic_org = FactoryGirl.build(:organization, name: "generic org", short_name: "go", zip: nil, street_1: nil)
      assert generic_org.valid?
    end

  
    should "show that if state is entered - if a zip is entered with it - the zip needs to be 5 digits" do
      generic_us_org = FactoryGirl.build(:organization, name: "generic org", short_name: "go")
      assert generic_us_org.valid?
      try_canadian_zip_with_state = FactoryGirl.build(:organization, name: "generic org", short_name: "go", zip: "X1X 1X1")
      deny try_canadian_zip_with_state.valid?
    end

    should "show that if zip is entered without a state, the zip should then be of Canadian format" do
      us_zip_wo_state = FactoryGirl.build(:organization, name: "generic org", short_name: "go", state: nil)
      deny us_zip_wo_state.valid?
      no_state_so_canadian_zip = FactoryGirl.build(:organization, name: "generic org", short_name: "go", state: nil, zip: "X1X 1X1")
      assert no_state_so_canadian_zip.valid?
      no_state_but_random_wrong_zip = FactoryGirl.build(:organization, name: "generic org", short_name: "go", state: nil, zip: "X1X 1X1 lalala")
      deny no_state_but_random_wrong_zip.valid?
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
