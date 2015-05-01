require 'test_helper'

class QuizTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:category)
  should belong_to(:event)
  should belong_to(:division)
  should have_many(:student_quizzes)
  should have_many(:students).through(:student_quizzes)
  should have_many(:quiz_teams)
  should have_many(:teams).through(:quiz_teams)

  # test validations
  should validate_presence_of(:event_id)
  should validate_presence_of(:division_id)
  should validate_presence_of(:category_id)
  should validate_numericality_of(:room_num).only_integer.is_greater_than(0)
  should validate_numericality_of(:round_num).only_integer.is_greater_than(0)

  context "Creating a context" do
    setup do
      create_one_organization
      create_events
      create_divisions
      create_categories
      create_quizzes_for_past_event
    end

    teardown do
      delete_one_organization
      delete_events
      delete_divisions
      delete_categories
      delete_quizzes_for_past_event
    end

    should "verify that the division is active in the system" do
      # test the inactive division first
      bad_quiz = FactoryGirl.build(:quiz, event: @event, division: @senior_b, round_num: 1, category: @category1)
      deny bad_quiz.valid?
      # test the nonexistent division
      junior_b = FactoryGirl.build(:division, name: "Junior B")
      bad_quiz = FactoryGirl.build(:quiz, division: junior_b, event: @event, category: @category1)
      deny bad_quiz.valid?
    end

    should "verify that the event is in the system" do
      # test the nonexistent event
      tourney = FactoryGirl.build(:event, organization: @acac)
      bad_quiz = FactoryGirl.build(:quiz, division: @senior_a, event: tourney, category: @category1)
      deny bad_quiz.valid?
    end

    should "Show that that the active scope works" do
      assert_equal 6, Quiz.active.size
    end

    should "show that the inactive scope works" do
      assert_equal 1, Quiz.inactive.size
    end

    should "have methods to make active or inactive" do
      @quiz1.make_inactive
      deny @quiz1.active
      @quiz1.make_active
      assert @quiz1.active
    end

  end #contexts
end #class
