require 'test_helper'

class TeamStandingTest < ActiveSupport::TestCase
	should validate_presence_of(:position)
	should validate_presence_of(:team_id)
	should validate_presence_of(:division_id)
	should validate_presence_of(:total_points)
	should validate_presence_of(:accuracy)

	# position
	should allow_value(1).for(:position)
	should allow_value(4).for(:position)
	
	should_not allow_value(0).for(:position)
	should_not allow_value(-1).for(:position)
	should_not allow_value(123456789).for(:position)
	should_not allow_value(1.2345).for(:position)
	should_not allow_value("zzzz").for(:position)


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
	context "Creating an TeamStanding context" do
		setup do
		  create_TeamStandings
		end

		teardown do
		  delete_TeamStandings
		end

		should "shows that standings are listed by position" do
		  assert_equal 1, TeamStanding.by_position.first.position
		end

		should "show that there are 3 junior division standings" do
			assert_equal 3, TeamStanding.for_juniors.size
		end

		should "show that there are 3 seniorb division standings" do
			assert_equal 3, TeamStanding.for_seniorb.size
		end 

		should "show that there are 3 senior A division standings" do
			assert_equal 3, TeamStanding.for_seniors.size
		end

		should "show the standing for a given team" do
			create_team
			assert_equal TeamStanding.for_team(@team1).team.name, "Test Test"
			delete_team

		end
	end


end
