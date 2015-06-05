class IndivStanding < ActiveRecord::Base

    # Relationships
    belongs_to :student
    belongs_to :team
    belongs_to :division
    
    # Validations
    validates_presence_of :position, :student_id, :team_id, :division_id, :total_points, :lowest_score, :adjusted_points, :accuracy

    validates_numericality_of :position, only_integer: true, greater_than: 0
    validates_numericality_of :student_id, only_integer: true, greater_than: 0
    validates_numericality_of :team_id, only_integer: true, greater_than: 0
    validates_numericality_of :division_id, only_integer: true, greater_than: 0
    validates_numericality_of :total_points, only_integer: true
    validates_numericality_of :lowest_score, only_integer: true
    validates_numericality_of :adjusted_points, only_integer: true
    validates_numericality_of :accuracy, greater_than_or_equal_to: 0, less_than: 1.01

    def self.for_indiv(indiv)
        is = where('student_id = ?', indiv.id).first
        if is.nil?
            return NullIndivStanding.new
        else
            return is
        end
    end

    def self.find_top_student(student)
        if student.current_team.division.name == "juniors"
            return IndivStanding.for_juniors
        elsif student.current_team.division.name == "seniors"
            return IndivStanding.for_seniors
        else
            return IndivStanding.for_seniorb
        end
    end

    def self.for_juniors(number=1000)
        juniors = where('division_id = ?', "#{Division.find_by_name('juniors').id}").limit(number).to_a
        juniors.empty? ? [NullIndivStanding.new] : juniors.sort
    end

    def self.for_seniors(number=1000)
        seniors = where('division_id = ?', "#{Division.find_by_name('seniors').id}").limit(number).to_a
        seniors.empty? ? [NullIndivStanding.new] : seniors.sort
    end

    def self.for_seniorb(number=1000)
        seniorb = where('division_id = ?', "#{Division.find_by_name('seniorb').id}").limit(number).to_a
        seniorb.empty? ? [NullIndivStanding.new] : seniorb.sort
    end

    def self.show_top_four(student)
        student_standing = IndivStanding.for_indiv(student)
        if IndivStanding.find_top_student(student)[0..3].include?(student_standing)
          return IndivStanding.find_top_student(student)[0..3]
        else 
          top3 = IndivStanding.find_top_student(student)[0..2]
          top3.append(student_standing)
          return top3
        end
    end

end