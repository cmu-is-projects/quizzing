class SettingsController < ApplicationController
	def index
		@setting = Setting.first
	end

	def edit
		@setting = Setting.first
	end
  
  	def update
    	if @setting.update(setting_params)
      		redirect_to @setting, notice: "Settings were updated in the system."
    	else
      		render action: 'edit'
    	end
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

	def setting_params
      params.permit(:drop_lowest_score, :roster_lock_date, :auto_promote_students, :area_name, :admin_name, :admin_email, :intro)
    end
end
