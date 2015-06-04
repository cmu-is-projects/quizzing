class TeamStandingsController < ApplicationController
	def index
		HardWorker.perform_async('bob',300)
		@juniors = TeamStanding.all.for_juniors
		@seniors = TeamStanding.all.for_seniors
		@seniorb = TeamStanding.all.for_seniorb
	end

	def juniors
		@juniors = TeamStanding.all.for_juniors
	end

	def seniors
		@seniors = TeamStanding.all.for_seniors
	end

	def seniorb
		@seniorb = TeamStanding.all.for_seniorb
	end

	def update_area_standings_now
		area = request.subdomain
		unless area.nil?
			HardWorker.perform_async()
	end
end