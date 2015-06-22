class SearchesController < ApplicationController
	include PgSearch
	def index
		@results = Student.search_by_name(params[:q])
		if @results.size < 1
			redirect_to request.referer, notice: "No students found named #{params[:q]}."
		elsif @results.size < 2
			redirect_to Student.find_by_id(@results.first)
		else
			@results
		end
			
	end
end