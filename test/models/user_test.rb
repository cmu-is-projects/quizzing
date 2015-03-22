require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test relationships
  should have_one(:coach)
  should have_secure_password

  #test validations
  should validate_presence_of(:user_name)
  should validate_presence_of(:role)
  should validate_uniquesness_of(:user_name).case_insensitive


  should allow_value("Lankly").for(:user_name)
  should allow_value("1234").for(:user_name)
  should_not allow_value(nil).for(:user_name)

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

    should "require users to have unique, case-insensitive usernames" do
      assert_equal "ProfH", @user2.user_name
      # try to switch to a coach's username all lower-case
      @user2.user_name = "coach1"
      deny @user2.valid?, "#{@user2.user_name}"
    end

    should "require a password for new users" do
      bad_user = FactoryGirl.build(:user, user_name: "wheezy", password: nil)
      deny bad_user.valid?
    end
    
    should "require passwords to be confirmed and matching" do
      bad_user_1 = FactoryGirl.build(:user, user_name: "wheezy", password: "secret", password_confirmation: nil)
      deny bad_user_1.valid?
      bad_user_2 = FactoryGirl.build(:user, user_name: "wheezy", password: "secret", password_confirmation: "sauce")
      deny bad_user_2.valid?
    end
    
    should "require passwords to be at least four characters" do
      bad_user = FactoryGirl.build(:user, user_name: "wheezy", password: "no", password_confirmation: "no")
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

    should "verify that the user_name is unique in the system" do
      deny FactoryGirl.build(:user, user_name: "Lankly").valid?
    end

    should "verify that the alphabetical scope works" do
      assert_equal ["Coach1","Coach2","InactiveCoach","Lankly","ProfH"], User.alphabetical.map(&:user_name)
    end

    should "verify that the active scope works" do
      assert_equal ["Coach1","Coach2","Lankly","ProfH"], User.active.alphabetical.map(&:user_name)
    end

    should "verify that the inactive scope works" do
      assert_equal ["InactiveCoach"], User.inactive.alphabetical.map(&:user_name)
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
