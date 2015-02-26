require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test relationships
  should have_one(:coach)

  #test validations
  should validate_presence_of(:user_name)
  should validate_presence_of(:role)
  should validate_presence_of(:password_hash)
  should validate_presence_of(:password_salt)

  should allow_value("Lankly").for(:user_name)
  should allow_value("1234").for(:user_name)
  should_not allow_value(nil).for(:user_name)

  should allow_value("admin").for(:role)
  should allow_value("area_admin").for(:role)
  should allow_value("coach").for(:role)
  should_not allow_value("superadmin").for(:role)
  should_not allow_value(1).for(:role)
  should_not allow_value(nil).for(:role)

  should_not allow_value("").for(:password_hash)
  should_not allow_value("").for(:password_salt)
  should_not allow_value(nil).for(:password_hash)
  should_not allow_value(nil).for(:password_salt)

  #set up a context
  include Contexts::UserContexts
  context "Creating a User context" do
    setup do
      create_users
    end

    teardown do
      delete_users
    end

    should "verify that the user_name is unique in the system" do
      deny FactoryGirl.build(:user, user_name: "Lankly").valid?
    end

    should "verify that the alphabetical scope works" do
      assert User.alphabetical.map(&:user_name) == ["Coach1","InactiveCoach","Lankly","ProfH"]
    end

    should "verify that the active scope works" do
      assert User.active.alphabetical.map(&:user_name) == ["Coach1","Lankly","ProfH"]
    end

    should "verify that the inactive scope works" do
      assert User.inactive.alphabetical.map(&:user_name) == ["InactiveCoach"]
    end

  end
end
