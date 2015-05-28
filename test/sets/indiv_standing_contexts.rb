module Contexts
  module IndivStandingContexts
    # assumes create_one_organization method already run...
    def create_divisions
      # creates divisions, one of each juniors, senior As, and senior B.

      @divisionj = FactoryGirl.create(:division, name: "juniors", start_grade: 1, end_grade: 5, active: true)
      @divisionsb = FactoryGirl.create(:division, name: "seniorb", start_grade: 6, end_grade: 8, active: true)
      @divisions = FactoryGirl.create(:division, name: "seniors", start_grade: 9, end_grade: 12, active: true)
    end

    def delete_divisions
      @divisionj.delete
      @divisionsb.delete
      @divisions.delete
    end

  	def create_IndivStandings
      create_divisions
      #create 3 standings for division 1
      @standing1 = FactoryGirl.create(:indiv_standing, position: 1, student_id: 1, team_id: 1, division_id: 1, total_points: 123, lowest_score: 23, adjusted_points: 110, accuracy: 0.85)
      @standing2 = FactoryGirl.create(:indiv_standing, position: 2, student_id: 2, team_id: 1, division_id: 1, total_points: 123, lowest_score: 23, adjusted_points: 110, accuracy: 0.85)
      @standing3 = FactoryGirl.create(:indiv_standing, position: 3, student_id: 3, team_id: 1, division_id: 1, total_points: 123, lowest_score: 23, adjusted_points: 110, accuracy: 0.85)

      #create 3 standings for div 2
      @standing4 = FactoryGirl.create(:indiv_standing, position: 1, student_id: 4, team_id: 1, division_id: 2, total_points: 123, lowest_score: 23, adjusted_points: 110, accuracy: 0.85)
      @standing5 = FactoryGirl.create(:indiv_standing, position: 2, student_id: 5, team_id: 1, division_id: 2, total_points: 123, lowest_score: 23, adjusted_points: 110, accuracy: 0.85)
      @standing6 = FactoryGirl.create(:indiv_standing, position: 3, student_id: 6, team_id: 1, division_id: 2, total_points: 123, lowest_score: 23, adjusted_points: 110, accuracy: 0.85)

      @standing7 = FactoryGirl.create(:indiv_standing, position: 1, student_id: 7, team_id: 1, division_id: 3, total_points: 123, lowest_score: 23, adjusted_points: 110, accuracy: 0.85)
      @standing8 = FactoryGirl.create(:indiv_standing, position: 2, student_id: 8, team_id: 1, division_id: 3, total_points: 123, lowest_score: 23, adjusted_points: 110, accuracy: 0.85)
      @standing9 = FactoryGirl.create(:indiv_standing, position: 3, student_id: 9, team_id: 1, division_id: 3, total_points: 123, lowest_score: 23, adjusted_points: 110, accuracy: 0.85)
  	end

  	def delete_IndivStandings
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