class StandingsController < ApplicationController
	def index
		@team_juniors = TeamStanding.all.for_juniors[0..4]
		@indiv_juniors = IndivStanding.all.for_juniors[0..4]

		@team_seniors = TeamStanding.all.for_seniors[0..4]
		@indiv_seniors = IndivStanding.all.for_seniors[0..4]

		@team_seniorb = TeamStanding.all.for_seniorb[0..4]
		@indiv_seniorb = IndivStanding.all.for_seniorb[0..4]
	end
end