class SettingsController < ApplicationController
	def index
	end

	def update_area_standings_now
		area = request.subdomain
		unless area.nil?
			HardWorker.perform_async(area)
		end

		redirect_to settings_url
	end
end
