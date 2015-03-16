module Contexts
  module TeamCoachContexts
    # need to have the organizations, users, coaches, teams methods run first
    def create_team_coaches
      @coach1_acac_sr1 = FactoryGirl.create(:team_coach, coach: @coach1, team: @acac_sr1, start_date: 3.years.ago.to_date)
      @coach2_acac_sr1 = FactoryGirl.create(:team_coach, coach: @coach2, team: @acac_sr1, start_date: 3.years.ago.to_date, end_date: 2.year.ago.to_date)
      @coach2_acac_sr2 = FactoryGirl.create(:team_coach, coach: @coach2, team: @acac_sr2, start_date: 2.years.ago.to_date, end_date: 1.year.ago.to_date)
      @coach2_acac_jr1 = FactoryGirl.create(:team_coach, coach: @coach2, team: @acac_jr1, start_date: 1.year.ago.to_date)
    end

    def delete_team_coaches
      @coach1_acac_sr1.delete
      @coach2_acac_sr1.delete
      @coach2_acac_sr2.delete
      @coach2_acac_jr1.delete
    end
  end
end