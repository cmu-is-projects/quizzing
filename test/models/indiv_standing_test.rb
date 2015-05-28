require 'test_helper'

class IndivStandingTest < ActiveSupport::TestCase

	should belong_to :student
	should belong_to :team
	should belong_to :division

	should validate_presence_of(:position)
	should validate_presence_of(:student_id)
	should validate_presence_of(:team_id)
	should validate_presence_of(:division_id)
	should validate_presence_of(:total_points)
	should validate_presence_of(:lowest_score)
	should validate_presence_of(:adjusted_points)
	should validate_presence_of(:accuracy)

	# position
	should allow_value(1).for(:position)
	should allow_value(4).for(:position)
	
	should_not allow_value(0).for(:position)
	should_not allow_value(-1).for(:position)
	should_not allow_value(123456789).for(:position)
	should_not allow_value(1.2345).for(:position)
	should_not allow_value("zzzz").for(:position)


	# student_id
	should allow_value(1).for(:student_id)
	should allow_value(4).for(:student_id)
	should allow_value(123456789).for(:student_id)

	should_not allow_value(0).for(:student_id)
	should_not allow_value(-1).for(:student_id)
	should_not allow_value(1.2345).for(:student_id)
	should_not allow_value("zzzz").for(:student_id)

	# team_id
	should allow_value(1).for(:team_id)
	should allow_value(4).for(:team_id)
	should allow_value(123456789).for(:team_id)

	should_not allow_value(0).for(:team_id)
	should_not allow_value(-1).for(:team_id)
	should_not allow_value(1.2345).for(:team_id)
	should_not allow_value("zzzz").for(:team_id)

	# division_id
	should allow_value(1).for(:division_id)
	should allow_value(4).for(:division_id)
	should allow_value(123456789).for(:division_id)

	should_not allow_value(0).for(:division_id)
	should_not allow_value(-1).for(:division_id)
	should_not allow_value(1.2345).for(:division_id)
	should_not allow_value("zzzz").for(:division_id)

	# total_points
	should allow_value(1).for(:total_points)
	should allow_value(4).for(:total_points)
	should allow_value(123456789).for(:total_points)

	should_not allow_value(0).for(:total_points)
	should_not allow_value(-1).for(:total_points)
	should_not allow_value(1.2345).for(:total_points)
	should_not allow_value("zzzz").for(:total_points)

	# lowest_score
	should allow_value(1).for(:lowest_score)
	should allow_value(4).for(:lowest_score)
	should allow_value(123456789).for(:lowest_score)

	should_not allow_value(0).for(:lowest_score)
	should_not allow_value(-1).for(:lowest_score)
	should_not allow_value(1.2345).for(:lowest_score)
	should_not allow_value("zzzz").for(:lowest_score)

	# adjusted_points
	should allow_value(1).for(:adjusted_points)
	should allow_value(4).for(:adjusted_points)
	should allow_value(123456789).for(:adjusted_points)

	should_not allow_value(0).for(:adjusted_points)
	should_not allow_value(-1).for(:adjusted_points)
	should_not allow_value(1.2345).for(:adjusted_points)
	should_not allow_value("zzzz").for(:adjusted_points)

	# accuracy
	should allow_value(1).for(:accuracy)
	should allow_value(0.99).for(:accuracy)
	should allow_value(0.23).for(:accuracy)
	should allow_value(0.00).for(:accuracy)

	should_not allow_value(123456789).for(:accuracy)
	should_not allow_value(4).for(:accuracy)
	should_not allow_value(-1).for(:accuracy)
	should_not allow_value(1.2345).for(:accuracy)
	should_not allow_value("zzzz").for(:accuracy)

	# scopes
	context "Creating an IndivStanding context" do
		setup do
		  create_IndivStandings
		end

		teardown do
		  delete_IndivStandings
		end

		should "shows that standings are listed by position" do
		  assert_equal 1, IndivStanding.by_position.first.position
		end

		should "show that there are 3 junior division standings" do
			assert_equal 3, IndivStanding.for_juniors.size
		end

		should "show that there are 3 seniorb division standings" do
			assert_equal 3, IndivStanding.for_seniorb.size
		end 

		should "show that there are 3 senior A division standings" do
			assert_equal 3, IndivStanding.for_seniors.size
		end
	end


end
