require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test relationships
  should have_one(:coach)
  should have_secure_password

  #test validations
  should validate_presence_of(:username)
  should validate_presence_of(:role)
  should validate_uniqueness_of(:username).case_insensitive
  
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

  should allow_value("Lankly").for(:username)
  should allow_value("1234").for(:username)
  should_not allow_value(nil).for(:username)

  should allow_value("admin").for(:role)
  should allow_value("area_admin").for(:role)
  should allow_value("coach").for(:role)
  should_not allow_value("superadmin").for(:role)
  should_not allow_value(1).for(:role)
  should_not allow_value(nil).for(:role)

  #set up a context
  context "Creating a User context" do
    setup do
      create_users
    end

    teardown do
      delete_users
    end

    should "require users to have unique, downcased usernames" do
      assert_equal "profh", @user2.username
      # try to switch to a coach's username all lower-case
      @user2.username = "coach1"
      deny @user2.valid?, "#{@user2.username}"
    end

    should "require a password for new users" do
      bad_user = FactoryGirl.build(:user, username: "wheezy", password: nil)
      deny bad_user.valid?
    end
    
    should "require passwords to be confirmed and matching" do
      bad_user_1 = FactoryGirl.build(:user, username: "wheezy", password: "secret", password_confirmation: nil)
      deny bad_user_1.valid?
      bad_user_2 = FactoryGirl.build(:user, username: "wheezy", password: "secret", password_confirmation: "sauce")
      deny bad_user_2.valid?
    end
    
    should "require passwords to be at least four characters" do
      bad_user = FactoryGirl.build(:user, username: "wheezy", password: "no", password_confirmation: "no")
      deny bad_user.valid?
    end

    should "have a role? method to use in authorization" do
      assert @user2.role?(:admin)
      deny @user1.role?(:admin)
      deny @user3.role?(:admin)
      assert @user1.role?(:area_admin)
      deny @user3.role?(:area_admin)
      assert @user3.role?(:coach)
    end

    should "verify that the username is unique in the system" do
      deny FactoryGirl.build(:user, username: "Lankly").valid?
    end

    should "verify that the alphabetical scope works" do
      assert_equal ["coach1","coach2","inactivecoach","lankly","profh"], User.alphabetical.map(&:username)
    end

    should "verify that the active scope works" do
      assert_equal ["coach1","coach2","lankly","profh"], User.active.alphabetical.map(&:username)
    end

    should "verify that the inactive scope works" do
      assert_equal ["inactivecoach"], User.inactive.alphabetical.map(&:username)
    end

    should "have methods to make active or inactive" do
      @user2.make_inactive
      deny @user2.active
      @user2.make_active
      assert @user2.active
    end

    should "have working is_x? methods" do
      assert @user2.is_admin?
      deny @user2.is_coach?
      assert @user1.is_area_admin?
      deny @user1.is_admin?
      assert @user3.is_coach?
      deny @user3.is_admin?
      deny @user3.is_area_admin?
    end

    should "have a humanize_role method" do
      assert_equal "Administrator", @user2.humanize_role
      assert_equal "Area Administrator", @user1.humanize_role
      assert_equal "Coach", @user3.humanize_role
    end

  end
end
