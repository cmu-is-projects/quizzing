module Contexts
	module CoachContexts
		# assumes create_one_organization and create_users methods run first...
		def create_coaches
			@coach1         = FactoryGirl.create(:coach, organization: @acac, user: @user3)
			@coach2         = FactoryGirl.create(:coach, organization: @acac, user: @user4, first_name: "Ted", last_name: "Stoe", phone: "412-268-2323")
			@coach_inactive = FactoryGirl.create(:coach, organization: @acac, first_name: "Inactive", active: false)
		end

		def delete_coaches
			@coach1.delete
			@coach2.delete
			@coach_inactive.delete
		end

		def create_extra_coaches
			@coach_tom = FactoryGirl.create(:coach, organization: @acac, user: @user6, first_name: "Tom", last_name: "Reay", phone: "0123456789")
		end

		def delete_extra_coaches
			@coach_tom.delete
		end

	end
end