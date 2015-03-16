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
  should validate_numericality_of(:room_num).only_integer.is_greater_than(0)
  should validate_numericality_of(:round_num).only_integer.is_greater_than(0)

  context "Creating a context" do
    setup do
      create_one_organization
      create_events
      create_divisions
      create_quizzes_for_past_event
    end

    teardown do
      delete_one_organization
      delete_events
      delete_divisions
      delete_quizzes_for_past_event
    end

    should "verify that the division is active in the system" do
      # test the inactive division first
      bad_quiz = FactoryGirl.build(:quiz, event: @event, division: @senior_b, round_num: 1)
      deny bad_quiz.valid?
      # test the nonexistent division
      junior_b = FactoryGirl.build(:division, name: "Junior B")
      bad_quiz = FactoryGirl.build(:quiz, division: junior_b, event: @event)
      deny bad_quiz.valid?
    end

    should "verify that the event is in the system" do
      # test the nonexistent event
      tourney = FactoryGirl.build(:event, organization: @acac)
      bad_quiz = FactoryGirl.build(:quiz, division: @senior_a, event: tourney)
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

  # Theophilus' old stuff
  # context "Creating an quiz context" do
  #   setup do
  #     create_categories
  #     create_divisions
  #     create_organizations
  #     create_events
  #     create_quizzes
  #   end
    
  #   teardown do
  #     delete_categories
  #     delete_quizzes
  #     delete_events
  #     delete_organizations
  #     delete_divisions
  #   end

  #   should "Show that that quiz's active scope works" do
  #     assert_equal 4, Quiz.active.size
  #     assert_equal [1,2,3,4], Quiz.active.all.map{|q| q.round_num}.sort
  #   end

  #   should "show that quiz's inactive scope works" do
  #     assert_equal 1, Quiz.inactive.size
  #     assert_equal [5], Quiz.inactive.all.map{|q| q.round_num}.sort
  #   end

  #   should "show that quiz can't be assigned to past event" do
  #     @past_event = FactoryGirl.build(:event, start_time: Time.now, start_date: Date.tomorrow, end_date: Date.tomorrow, num_rounds: 2)
  #     bad_quiz = FactoryGirl.build(:quiz, division: @division1, event: @past_event, category: @category1)
  #     deny bad_quiz.valid?
  #   end


    #test scope by_round
    #need method to ensure uniqueness of event, division, round uniqueness
    
    #ensure division is active in system
    # should "ensure that division is active in system" do 
    # @bad_quiz = FactoryGirl.build(:quiz)
    # end
    

  end #contexts
end #class
