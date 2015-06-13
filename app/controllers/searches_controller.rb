class SearchesController < ApplicationController
	include PgSearch
	def index
		@results = PgSearch.multisearch(params[:q])
		if @results.size < 1
			#redirect_to home_url
		elsif @results.size < 2
			redirect_to Student.find_by_id(@results.first.searchable_id)
		else
			@results
		end
			
	end
end