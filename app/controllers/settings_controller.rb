class SettingsController < ApplicationController
	def index
	end

	def update_area_standings
		area = request.subdomain
		unless area.nil?
			HardWorker.perform_async(area)
			redirect_to settings_url, notice: 'Standings are now being updated.'
		end
	end

	def update_indiv_standings
		area = request.subdomain
		unless area.nil?
			IndivWorker.perform_async(area)
			redirect_to settings_url, notice: 'Standings are now being updated.'
		end
	end

	def update_team_standings
		area = request.subdomain
		unless area.nil?
			TeamWorker.perform_async(area)
			redirect_to settings_url, notice: 'Standings are now being updated.'
		end
	end
end
