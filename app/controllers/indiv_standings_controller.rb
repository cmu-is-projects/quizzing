class IndivStandingsController < ApplicationController
	def juniors
		IndivStandings.all.for_juniors.empty? ? NullIndivStanding.new : @juniors = IndivStandings.all.for_juniors.by_position
	end

	def seniors
		IndivStandings.all.for_seniors.empty? ? NullIndivStanding.new : @seniors = IndivStandings.all.for_seniors
	end

	def seniorb
		IndivStandings.all.for_seniorb.empty? ? NullIndivStanding.new : @seniorb = IndivStandings.all.for_seniorb
	end
end