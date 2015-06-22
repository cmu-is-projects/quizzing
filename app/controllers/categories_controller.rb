class CategoriesController < ApplicationController

	def toggle_quiz_question
		@category = Category.find(params[:id])
		@category.active = params[:active] unless params[:active].nil?
		@category.save!
		@categories = Category.all
	end
end
