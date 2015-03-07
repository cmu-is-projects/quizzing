module Contexts
  module TeamContexts

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
end
