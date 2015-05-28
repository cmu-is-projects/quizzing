module Contexts
  module TeamStandingContexts
    def create_divisions
      # creates divisions, one of each juniors, senior As, and senior B.

      @divisionj = FactoryGirl.create(:division, name: "juniors", start_grade: 2, end_grade: 5, active: true)
      @divisionsb = FactoryGirl.create(:division, name: "seniorb", start_grade: 6, end_grade: 8, active: true)
      @divisions = FactoryGirl.create(:division, name: "seniors", start_grade: 9, end_grade: 12, active: true)
    end

    def delete_divisions
      @divisionj.delete
      @divisionsb.delete
      @divisions.delete
    end

    def create_team
      @organization1 = FactoryGirl.create(:organization, name: "Org Place", short_name: "OP", street_1: "155 Allegheny Avenue", street_2: nil, city: "Pittsburgh", state: "Pennsylvania", zip: :"15212", latitude: nil, longitude: nil, active: true, primary_contact: nil)
      @team1 = FactoryGirl.create(:team, division: @divisions, organization: @organization1, name: "Team Team", active: true)
    end

    def delete_team
      @organization1.delete
      @team1.delete
    end

  	def create_TeamStandings
      create_divisions
      #create 3 standings for division 1
      @standing1 = FactoryGirl.create(:team_standing, position: 1, team_id: 1, division_id: 1, total_points: 123, accuracy: 0.85)
      @standing2 = FactoryGirl.create(:team_standing, position: 2, team_id: 1, division_id: 1, total_points: 123, accuracy: 0.85)
      @standing3 = FactoryGirl.create(:team_standing, position: 3, team_id: 1, division_id: 1, total_points: 123, accuracy: 0.85)

      #create 3 standings for div 2
      @standing4 = FactoryGirl.create(:team_standing, position: 1, team_id: 1, division_id: 2, total_points: 123, accuracy: 0.85)
      @standing5 = FactoryGirl.create(:team_standing, position: 2, team_id: 1, division_id: 2, total_points: 123, accuracy: 0.85)
      @standing6 = FactoryGirl.create(:team_standing, position: 3, team_id: 1, division_id: 2, total_points: 123, accuracy: 0.85)

      @standing7 = FactoryGirl.create(:team_standing, position: 1, team_id: 1, division_id: 3, total_points: 123, accuracy: 0.85)
      @standing8 = FactoryGirl.create(:team_standing, position: 2, team_id: 1, division_id: 3, total_points: 123, accuracy: 0.85)
      @standing9 = FactoryGirl.create(:team_standing, position: 3, team_id: 1, division_id: 3, total_points: 123, accuracy: 0.85)
  	end

  	def delete_TeamStandings
      delete_divisions
  		@standing1.delete
      @standing2.delete
      @standing3.delete
      @standing4.delete
      @standing5.delete
      @standing6.delete
      @standing7.delete
      @standing8.delete
      @standing9.delete
  	end
  end
end