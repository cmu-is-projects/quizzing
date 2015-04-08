class StandingsController < ApplicationController
  def individual
  	if params[:id].nil?
  		#division
  		div_id = get_default_div_id
  	else
  		div_id = params[:id]
  		
  	end
  	division = Division.find(div_id)
  	#TODO: adjust this to ultimately take a QuizYear parameter (probably NOT during CMU  67-373 Spring 2015)
  	@quizzers = YearQuizzer.get_all_quizzers_for_division_for_year(division)
  end #end individual method

  def team
  end

  private
  def get_default_div_id
  	Division.alphabetical.all.map(&:id).first
  end
end
