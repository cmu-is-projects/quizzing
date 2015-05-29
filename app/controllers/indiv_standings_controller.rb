class IndivStandingsController < ApplicationController
	def juniors
		@juniors = IndivStanding.all.for_juniors
	end

	def seniors
		@seniors = IndivStanding.all.for_seniors
	end

	def seniorb
		@seniorb = IndivStanding.all.for_seniorb
	end
end