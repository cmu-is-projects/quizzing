class IndivStandingsController < ApplicationController
	def index
		@juniors = IndivStanding.all.for_juniors
		@seniors = IndivStanding.all.for_seniors
		@seniorb = IndivStanding.all.for_seniorb
	end

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