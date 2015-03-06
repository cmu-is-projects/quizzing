require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  should have_many(:quizzes)

  should validate_presence_of(:name)
  should validate_uniqueness_of(:name).case_insensitive

    #set up a context
  context "Creating a Category context" do
    
    setup do
      create_categories
    end

    teardown do
      delete_categories
    end

    should "verify that name is unique in the system" do
      deny FactoryGirl.build(:category, name: "Category One").valid?
    end

    should "verify that the alphabetical scope works" do
      assert Category.alphabetical.map(&:name) == ["Category Inactive", "Category One", "Category Two"]
    end

  end #context
end
