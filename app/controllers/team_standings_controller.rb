class TeamStandingsController < ApplicationController
	def juniors
		@juniors = TeamStandings.all.for_juniors
	end

	def seniors
		@seniors = TeamStandings.all.for_seniors
	end

	def seniorb
		@seniorb = TeamStandings.all.for_seniorb
	end
end