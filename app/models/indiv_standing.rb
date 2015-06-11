class IndivStanding < ActiveRecord::Base

    # Relationships
    belongs_to :student
    belongs_to :team
    belongs_to :division
    belongs_to :organization
    
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
            return for_juniors.first
        elsif student.current_team.division.name == "seniors"
            return for_seniors.first
        else
            return for_seniorb.first
        end
    end

    def self.show_top_four(student)
      if student.current_team.division.name == "juniors"
        list = for_juniors(5)
      elsif student.current_team.division.name == "seniors"
        list = for_seniors(5)
      else
        list = for_seniorb(5)
      end
      stu = for_student(student)
      unless list.include?(stu)
        list.pop
        list << stu
      end
      return list
    end

    def self.for_juniors(number=1000, organization=nil)
      if organization.nil?
        juniors = where('indiv_standings.division_id = 1').order(:position).joins(:student,:team).select("indiv_standings.*, concat(students.first_name,' ',students.last_name) as student_name, students.id as student_id, teams.name as team_name, teams.id as team_id").limit(number).to_a
      else
        juniors = where('indiv_standings.division_id = 1 and indiv_standings.organization_id = ?', organization.id).order(:position).joins(:student,:team).select("indiv_standings.*, concat(students.first_name,' ',students.last_name) as student_name, students.id as student_id, teams.name as team_name, teams.id as team_id").limit(number).to_a      
      end
      juniors.empty? ? [NullIndivStanding.new] : juniors
    end

    def self.for_seniors(number=1000, organization=nil)
      if organization.nil?
        seniors = where('indiv_standings.division_id = 2').order(:position).joins(:student,:team).select("indiv_standings.*, concat(students.first_name,' ',students.last_name) as student_name, students.id as student_id, teams.name as team_name, teams.id as team_id").limit(number).to_a
      else
        seniors = where('indiv_standings.division_id = 2 and indiv_standings.organization_id = ?', organization.id).order(:position).joins(:student,:team).select("indiv_standings.*, concat(students.first_name,' ',students.last_name) as student_name, students.id as student_id, teams.name as team_name, teams.id as team_id").limit(number).to_a      
      end
      seniors.empty? ? [NullIndivStanding.new] : seniors
    end

    def self.for_seniorb(number=1000, organization=nil)
      if organization.nil?
        seniorb = where('indiv_standings.division_id = 3').limit(number).order(:position).joins(:student,:team).select("indiv_standings.*, concat(students.first_name,' ',students.last_name) as student_name, students.id as student_id, teams.name as team_name, teams.id as team_id").to_a
      else
        seniorb = where('indiv_standings.division_id = 3 and indiv_standings.organization_id = ?', organization.id).order(:position).joins(:student,:team).select("indiv_standings.*, concat(students.first_name,' ',students.last_name) as student_name, students.id as student_id, teams.name as team_name, teams.id as team_id").limit(number).to_a      
      end
      seniorb.empty? ? [NullIndivStanding.new] : seniorb
    end 

    def self.for_student(student)
      juniors = where('indiv_standings.student_id = ?', student.id).joins(:student,:team).select("indiv_standings.*, concat(students.first_name,' ',students.last_name) as student_name, students.id as student_id, teams.name as team_name, teams.id as team_id").first      
      juniors.nil? ? NullIndivStanding.new : juniors
    end

  end