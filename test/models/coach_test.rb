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
  include Contexts::CoachContexts
  context "Creating a Coach context" do
  	setup do
  		create_coaches
  	end

  	teardown do
  		delete_coaches
  	end

  	should "verify that the alphabetical scope works" do
  		assert Coach.alphabetical.map(&:first_name) == ["Inactive","Rob","Ted"]
  	end

  	should "show that name method works" do
  		assert_equal "Stanton, Rob", @coach1.name
  		assert_equal "Stoe, Ted", @coach2.name
  	end

  	should "show that proper_name method works" do
  		assert_equal "Rob Stanton", @coach1.proper_name
  		assert_equal "Ted Stoe", @coach2.proper_name
  	end  	  	

  	# should "verify that the coach's organization is active in the system" do
  	# 	@inactive_organization = FactoryGirl.create(:organization, active: false)
  	# 	bad_coach = FactoryGirl.build(:coach, organization: @inactive_organization)
  	# 	deny bad_coach.valid?
  	# 	@inactive_organization.delete
  	# end
end
end
