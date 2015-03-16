module Contexts
  module TeamContexts

    def create_teams
      @team1 = FactoryGirl.create(:team, organization: @organization1, division: @division1)
      @team2 = FactoryGirl.create(:team, name: "Team Two", division: @division1, organization: @organization1)
      @team3 = FactoryGirl.create(:team, name: "Team Inactive", division: @division1, organization: @organization1, active: false)
    end
    
    def delete_teams
      @team1.delete unless @team1.nil?
      @team2.delete unless @team2.nil?
      @team3.delete unless @team3.nil?
    end
    
  end
end
