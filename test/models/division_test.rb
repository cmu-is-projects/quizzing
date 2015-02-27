require 'test_helper'

class DivisionTest < ActiveSupport::TestCase
  # test relationships
  should have_many(:quizzes)
  should have_many(:teams)

  #test validations
  should validate_presence_of(:name)

  #set up a context
  include Contexts::DivisionContexts
  context "Creating a Division context" do
    
    setup do
      create_divisions
    end

    teardown do
      delete_divisions
    end

    should "verify that name is unique in the system" do
      deny FactoryGirl.build(:division, name: "Senior A").valid?
    end

    should "verify that the alphabetical scope works" do
      assert Division.alphabetical.map(&:name) == ["Junior","Senior A","Senior B"]
    end

  end

end
