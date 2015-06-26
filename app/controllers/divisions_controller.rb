class DivisionsController < ApplicationController
	respond_to :html, :json

	def toggle_division
		@division =Division.find(params[:id])
		@division.active = params[:active] unless params[:active].nil?
		@division.save!
		@divisions = Division.all 
	end

	def update
		@division = Division.find(params[:id])
		@division.start_grade = params[:start_grade] unless params[:start_grade].nil?
		@division.end_grade = params[:end_grade] unless params[:end_grade].nil?
		@division.save!
		@division.update(division_params)
		@divisions = Division.all 	
		@setting = Setting.first
		respond_with @division 
		# redirect_to	
	end

	def division_params
      params.require(:division).permit(:name, :start_grade, :end_grade, :active)
    end
end
