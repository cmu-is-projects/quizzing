module Contexts
	module CoachContexts

		def create_coaches
			@coach1 = FactoryGirl.create(:coach, organization: @organization_1, user: @user1)
			@coach2 = FactoryGirl.create(:coach, organization: @organization_2, user: @user2, first_name: "Ted", last_name: "Stoe", email: "tstoe@cma.org")
			@coach_inactive = FactoryGirl.create(:coach, organization: @organization_1, user: @user1, first_name: "Inactive", email: "inactive@cma.org", active: false)
		end

		def delete_coaches
			@coach1.delete unless @coach1.nil?
			@coach2.delete unless @coach2.nil?
			@coach_inactive.delete unless @coach_inactive.nil?
		end

	end
end