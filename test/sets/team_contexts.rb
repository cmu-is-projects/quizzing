module Contexts
  module TeamContexts

    def create_acac_teams
      @acac_jr1 = FactoryGirl.create(:team, division: @junior, organization: @acac, name: "ACAC JR1")
      @acac_sr3 = FactoryGirl.create(:team, division: @senior_a, organization: @acac, name: "ACAC 3", active: false)
      @acac_sr1 = FactoryGirl.create(:team, division: @senior_a, organization: @acac, name: "ACAC 1")
      @acac_sr2 = FactoryGirl.create(:team, division: @senior_a, organization: @acac, name: "ACAC 2")
    end

    def delete_acac_teams
      @acac_sr1.delete
      @acac_sr2.delete
      @acac_sr3.delete
      @acac_jr1.delete
    end

    def create_teams
      create_acac_teams
      @somerset_sr1 = FactoryGirl.create(:team, division: @senior_a, organization: @somerset, name: "Somerset 1")
    end
    
    def delete_teams
      delete_acac_teams
      @somerset_sr1.delete
    end

    def create_senior_b_teams
      @acac_srb1 = FactoryGirl.create(:team, division: @senior_b, organization: @acac, name: "ACAC SRB1")
      @acac_srb2 = FactoryGirl.create(:team, division: @senior_b, organization: @acac, name: "ACAC SRB2")
    end

    def delete_senior_b_teams
      @acac_srb1.delete
      @acac_srb2.delete
    end
    
  end
end
