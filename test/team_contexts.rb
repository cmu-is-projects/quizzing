module Contexts
  module TeamContexts

    def create_teams
      @team1 = FactoryGirl.create(:team)
      @team2 = FactoryGirl.create(:team, name: "Team Two", division_id: 2, organization_id: 2)
      @team3 = FactoryGirl.create(:team, name: "Team Inactive", active: false)
    end
    
    def delete_teams
      @team1.delete unless @team1.nil?
      @team2.delete unless @team2.nil?
    end
    
  end
end
