module Contexts
	module CoachContexts

		def create_coaches
			@coach1 = FactoryGirl.create(:coach)
			@coach2 = FactoryGirl.create(:coach, first_name: "Ted", last_name: "Stoe")
			@coach_inactive = FactoryGirl.create(:coach, first_name: "Inactive", active: false)
		end

		def delete_coaches
			@coach1.delete unless @coach1.nil?
			@coach2.delete unless @coach2.nil?
			@coach_inactive.delete unless @coach_inactive.nil?
		end

	end
end