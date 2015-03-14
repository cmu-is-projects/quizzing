require 'test_helper'

class DivisionTest < ActiveSupport::TestCase
  # test relationships
  should have_many(:quizzes)
  should have_many(:teams)

  #test validations
  should validate_presence_of(:name)
  should validate_numericality_of(:start_grade).only_integer.is_greater_than(1).is_less_than(13)
  should validate_numericality_of(:end_grade).only_integer.is_greater_than(1).is_less_than(13)

  #set up a context
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
      assert_equal ["Junior","Senior A","Senior B"], Division.alphabetical.map(&:name)
    end

    should "Show that that the active scope works" do
      assert_equal 2, Division.active.size
      assert_equal ["Junior","Senior A"], Division.active.all.map{|d| d.name}.sort
    end

    should "show that the inactive scope works" do
      assert_equal 1, Division.inactive.size
      assert_equal ["Senior B"], Division.inactive.all.map{|d| d.name}.sort
    end

    should "have methods to make active or inactive" do
      @senior_a.make_inactive
      deny @senior_a.active
      @senior_a.make_active
      assert @senior_a.active
    end

  end

end
