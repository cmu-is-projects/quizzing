module Contexts
	def create_organizations
		@org1 = FactoryGirl.create(:org)
		sleep 1
		@org2 = FactoryGirl.create(:org, name: "Org Two", primary_contact: 2)
		sleep 1
		@org_inactive = FactoryGirl.create(:org, name: "Org Inactive", active: false)
	end

	def destroy_organizations
		@org1.destroy
		@org2.destroy
		@org_inactive.destroy
	end

	def create_quizzes
		@quiz1 = FactoryGirl.create(:quiz)
		@quiz2 = FactoryGirl.create(:quiz, room_num: 2)
		@quiz3 = FactoryGirl.create(:quiz, room_num: 3, division_id: 2)
		@quiz4 = FactoryGirl.create(:quiz, event_id: 2, round_num: 2)
		@quiz_inactive = FactoryGirl.create(:quiz, active: false)

	end

	def destroy_quizzes
		@quiz1.destroy
		@quiz2.destroy
		@quiz3.destroy
		@quiz4.destroy
		@quiz_inactive.destroy
	end

	def create_teams
		@team1 = FactoryGirl.create(:team)
		@team2 = FactoryGirl.create(:team, name: "Team Two", division_id: 2, organization_id: 2)
		@team3 = FactoryGirl.create(:team, active: false)
	end

	def destroy_teams
		@team1.destroy
		@team2.destroy
	end
	
end
