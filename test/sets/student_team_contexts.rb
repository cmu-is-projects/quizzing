module Contexts
  module StudentTeamContexts
    # need to have the organization, students, teams methods run first
    def create_acac_student_teams
      @mark_acac_sr1     = FactoryGirl.create(:student_team, student: @mark, team: @acac_sr1, is_captain: true, start_date: 3.years.ago.to_date)
      @alex_acac_sr1     = FactoryGirl.create(:student_team, student: @alex, team: @acac_sr1, start_date: 3.years.ago.to_date)
      @quincy_acac_sr1   = FactoryGirl.create(:student_team, student: @quincy, team: @acac_sr1, start_date: 34.months.ago.to_date, end_date: 13.months.ago.to_date)
      @amanda_acac_sr2   = FactoryGirl.create(:student_team, student: @amanda, team: @acac_sr2, is_captain: true, start_date: 2.years.ago.to_date)
      @jonathan_acac_jr1 = FactoryGirl.create(:student_team, student: @jonathan, team: @acac_jr1, start_date: 11.months.ago.to_date)
    end

    def delete_acac_student_teams
      @mark_acac_sr1.delete
      @alex_acac_sr1.delete
      @quincy_acac_sr1.delete
      @amanda_acac_sr2.delete
      @jonathan_acac_jr1.delete
    end

    def create_senior_b_student_teams
      @nate_acac_srb1 = FactoryGirl.create(:student_team, student: @nate, team: @acac_srb1, is_captain: true, start_date: 3.years.ago.to_date)   
    end

    def delete_senior_b_student_teams
      @nate_acac_srb1.delete
    end

    # created for the sake of testing quincy having a team
    def create_quincy_has_a_team
      @mark_acac_sr1     = FactoryGirl.create(:student_team, student: @mark, team: @acac_sr1, is_captain: true, start_date: 3.years.ago.to_date)
      @alex_acac_sr1     = FactoryGirl.create(:student_team, student: @alex, team: @acac_sr1, start_date: 3.years.ago.to_date)
      @quincy_acac_sr1   = FactoryGirl.create(:student_team, student: @quincy, team: @acac_sr1, start_date: 34.months.ago.to_date)
      @amanda_acac_sr2   = FactoryGirl.create(:student_team, student: @amanda, team: @acac_sr2, is_captain: true, start_date: 2.years.ago.to_date)
      @jonathan_acac_jr1 = FactoryGirl.create(:student_team, student: @jonathan, team: @acac_jr1, start_date: 11.months.ago.to_date)
    end

    def delete_quincy_has_a_team
      @mark_acac_sr1.delete
      @alex_acac_sr1.delete
      @quincy_acac_sr1.delete
      @amanda_acac_sr2.delete
      @jonathan_acac_jr1.delete
    end

    def create_student_teams
      create_acac_student_teams
      @jimmy_somerset_sr1  = FactoryGirl.create(:student_team, student: @jimmy, team: @somerset_sr1, is_captain: true, start_date: 3.years.ago.to_date)
      @mindy_somerset_sr1  = FactoryGirl.create(:student_team, student: @mindy, team: @somerset_sr1, start_date: 3.years.ago.to_date)
      @quincy_somerset_sr1 = FactoryGirl.create(:student_team, student: @quincy, team: @somerset_sr1, start_date: 1.year.ago.to_date)
    end

    def delete_student_teams
      delete_acac_student_teams
      @jimmy_somerset_sr1.delete
      @mindy_somerset_sr1.delete
      @quincy_somerset_sr1.delete
    end

    def create_senior_b_student_teams
      @nate_acac_srb1 = FactoryGirl.create(:student_team, student: @nate, team: @acac_srb1, is_captain: true, start_date: 3.years.ago.to_date)
      @dean_acac_srb1 = FactoryGirl.create(:student_team, student: @dean, team: @acac_srb1, start_date: 1.year.ago.to_date)
      @livie_acac_srb1 = FactoryGirl.create(:student_team, student: @livie, team: @acac_srb1, start_date: 1.year.ago.to_date)

      @artem_acac_srb2 = FactoryGirl.create(:student_team, student: @artem, team: @acac_srb2, start_date: 2.years.ago.to_date)
      @aaron_acac_srb2 = FactoryGirl.create(:student_team, student: @aaron, team: @acac_srb2, start_date: 1.year.ago.to_date)
      @jayla_acac_srb2 = FactoryGirl.create(:student_team, student: @jayla, team: @acac_srb2, is_captain: true, start_date: 3.years.ago.to_date)
    end

    def delete_senior_b_student_teams
      @nate_acac_srb1.delete
      @dean_acac_srb1.delete
      @livie_acac_srb1.delete

      @artem_acac_srb2.delete
      @aaron_acac_srb2.delete
      @jayla_acac_srb2.delete
    end
  
  end
end
