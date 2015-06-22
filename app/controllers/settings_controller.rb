class SettingsController < ApplicationController
	def index
		@setting = Setting.first
		@divisions = Division.all 
		@categories = Category.all
	end

	def edit
		@setting = Setting.first
	end
  
  	def update
  		@setting = Setting.first
    	if @setting.update(setting_params)
      		redirect_to settings_url, notice: "Settings were updated in the system."
    	else
      		render action: 'edit'
    	end
  	end
	def update_area_standings
		area = request.subdomain
		unless area.nil?
			HardWorker.perform_async(area)
			redirect_to settings_url, notice: 'All standings are now being updated.'
		end
	end

	def update_indiv_standings
		area = request.subdomain
		unless area.nil?
			IndivWorker.perform_async(area)
			redirect_to settings_url, notice: 'Individual standings are now being updated.'
		end
	end

	def update_team_standings
		area = request.subdomain
		unless area.nil?
			TeamWorker.perform_async(area)
			redirect_to settings_url, notice: 'Team standings are now being updated.'
		end
	end


	def setting_params
      params.require(:setting).permit(:drop_lowest_score, :roster_lock_date, :roster_lock_toggle, :auto_promote_students, :area_name, :admin_name, :admin_email, :intro)
    end
end
