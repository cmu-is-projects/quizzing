class StandingsController < ApplicationController
	def index
		@team_juniors = TeamStanding.all.for_juniors
		@indiv_juniors = IndivStanding.all.for_juniors

		@team_seniors = TeamStanding.all.for_seniors
		@indiv_seniors = IndivStanding.all.for_seniors

		@team_seniorb = TeamStanding.all.for_seniorb
		@indiv_seniorb = IndivStanding.all.for_seniorb
	end
end