class TeamStandingsController < ApplicationController
	def index
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

	def update_area_standings_now_please
		area = request.subdomain
		unless area.nil?
			HardWorker.perform_async(area)
		end

		redirect_to settings_url
	end
end