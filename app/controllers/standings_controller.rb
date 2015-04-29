class StandingsController < ApplicationController
  def individual
  	if params[:id].nil?
  		#division
  		division_id = get_default_division_id
  	else
  		division_id = params[:id]
  	end
    
  	@division = Division.find(division_id)
  	#TODO (probably NOT during CMU 67-373 Spring 2015): adjust this to ultimately take a QuizYear parameter
  	@year_quizzers = YearQuizzer.get_all_quizzers_for_division_for_year(@division)
  end #end individual method

  def team
    @divisions = Division.all.alphabetical
  end

  private
  def get_default_division_id
  	Division.alphabetical.all.map(&:id).first
  end
end
