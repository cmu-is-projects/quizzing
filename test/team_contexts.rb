module Contexts
  module TeamContexts

    def create_teams
      @team1 = FactoryGirl.create(:team, organization: @organization1, division: @div1)
      @team2 = FactoryGirl.create(:team, name: "Team Two", division: @div1, organization: @organization1)
      @team3 = FactoryGirl.create(:team, name: "Team Inactive", division: @div1, organization: @organization1, active: false)
    end
    
    def delete_teams
      @team1.delete unless @team1.nil?
      @team2.delete unless @team2.nil?
      delete_organizations
    end
    
  end
end
