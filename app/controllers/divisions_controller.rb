class DivisionsController < ApplicationController

	def toggle_division
		@division =Division.find(params[:id])
		@division.active = params[:active] unless params[:active].nil?
		@division.save!
		@divisions = Division.all 
	end
end
