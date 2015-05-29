class TeamStandingsController < ApplicationController
	def juniors
		TeamStandings.all.for_juniors.empty? ? NullTeamStanding.new : TeamStandings.all.for_juniors
	end

	def seniors
		TeamStandings.all.for_seniors.empty? ? NullTeamStanding.new : TeamStandings.all.for_seniors
	end

	def seniorb
		TeamStandings.all.for_seniorb.empty? ? NullTeamStanding.new : TeamStandings.all.for_seniorb
	end
end
