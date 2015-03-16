require 'test_helper'

class CoachTest < ActiveSupport::TestCase
  # validations
  should belong_to(:organization)
  should have_many(:team_coaches)
  should have_many(:teams).through(:team_coaches)
  should belong_to(:user)
  
  should accept_nested_attributes_for(:user).allow_destroy(true)

  should validate_presence_of(:user_id)
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:email)

  should allow_value("fred@fred.com").for(:email)
  should allow_value("fred@andrew.cmu.edu").for(:email)
  should allow_value("my_fred@fred.org").for(:email)
  should allow_value("fred123@fred.gov").for(:email)
  should allow_value("my.fred@fred.net").for(:email)
  
  should_not allow_value("fred").for(:email)
  should_not allow_value("fred@fred,com").for(:email)
  should_not allow_value("fred@fred.uk").for(:email)
  should_not allow_value("my fred@fred.com").for(:email)
  should_not allow_value("fred@fred.con").for(:email)

  should allow_value("4122683259").for(:phone)
  should allow_value("412-268-3259").for(:phone)
  should allow_value("412.268.3259").for(:phone)
  should allow_value("(412) 268-3259").for(:phone)

  should_not allow_value("2683259").for(:phone)
  should_not allow_value("4122683259x224").for(:phone)
  should_not allow_value("800-EAT-FOOD").for(:phone)
  should_not allow_value("412/268/3259").for(:phone)
  should_not allow_value("412-2683-259").for(:phone)

  #set up context
  context "Creating a Coach context" do
  	setup do
      create_one_organization
      create_users
  		create_coaches
  	end

  	teardown do
      delete_one_organization
      delete_users
  		delete_coaches
      delete_users
      delete_organizations
  	end

  	should "verify that the alphabetical scope works" do
  		assert_equal ["Inactive","Rob","Ted"], Coach.alphabetical.map(&:first_name)
  	end

    should "Show that that the active scope works" do
      assert_equal 2, Coach.active.size
      assert_equal ["Rob","Ted"], Coach.active.all.map{|a| a.first_name}.sort
    end

    should "show that the inactive scope works" do
      assert_equal 1, Coach.inactive.size
      assert_equal ["Inactive"], Coach.inactive.all.map{|a| a.first_name}.sort
    end

    should "have methods to make active or inactive" do
      @coach1.make_inactive
      deny @coach1.active
      @coach1.make_active
      assert @coach1.active
    end

  	should "show that name method works" do
  		assert_equal "Stanton, Rob", @coach1.name
  		assert_equal "Stoe, Ted", @coach2.name
  	end

  	should "show that proper_name method works" do
  		assert_equal "Rob Stanton", @coach1.proper_name
  		assert_equal "Ted Stoe", @coach2.proper_name
  	end  	  	

    should "verify that the organization is active in the system" do
      # test the inactive organization first
      grove_city = FactoryGirl.create(:organization, name: "Grove City Church", short_name: "Grove City", active: false)
      bad_coach = FactoryGirl.build(:coach, organization: grove_city)
      deny bad_coach.valid?
      grove_city.delete
      # test the nonexistent organization
      grove_city = FactoryGirl.build(:organization, name: "Grove City Church", short_name: "Grove City", active: true)
      bad_coach = FactoryGirl.build(:coach, organization: grove_city)
      deny bad_coach.valid?
    end 

    should "correctly assess that a coach is not destroyable" do
      deny @coach1.destroy
    end

    should "deactivate the user if the coach is made inactive" do
      @coach1.make_inactive
      deny @coach1.user.active
    end

    should "reformat phone number before saving" do
      assert_equal "4122682323", @coach2.phone
    end

  end
end

