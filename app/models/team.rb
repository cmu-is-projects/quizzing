class Team < ActiveRecord::Base
  # get modules to help with some functionality
  include QuizHelpers::Validations
  include Activeable
  
  #Relationships
  belongs_to :organization
  belongs_to :division
  has_many :student_teams
  has_many :students, through: :student_teams
  has_many :quiz_teams
  has_many :quizzes, through: :quiz_teams
  has_many :team_coaches
  has_many :coaches, through: :team_coaches

  has_one :team_standing
  has_many :indiv_standings

  accepts_nested_attributes_for :coaches
  accepts_nested_attributes_for :student_teams,
  reject_if: proc {|attr| attr['student_id'].blank?}
  accepts_nested_attributes_for :organization
  accepts_nested_attributes_for :team_coaches

  #Validations
  validates_presence_of :division_id, :name, :organization_id
  # validates_uniqueness_of :name, case_sensitive: false

  
  #Scopes
  scope :alphabetical, -> {order("name")}
  # scope :for_division, -> (division) { where(division_id: division.id)}


  #Methods
  validate :division_is_active_in_system
  validate :organization_is_active_in_system

  # Callbacks
  before_destroy :verify_that_there_are_no_scored_quizzes_for_team_this_year



  def self.for_juniors(number=1000, organization=nil)
    if organization.nil?
      juniors = where('division_id = ?', "#{Division.find_by_name('juniors').id}").limit(number).to_a
    else
      juniors = where('division_id = ? and organization_id = ?', "#{Division.find_by_name('juniors').id}", organization.id).limit(number).to_a      
    end
      juniors.empty? ? [NullTeam.new] : juniors.sort_by{|t| t.name}
  end

  def self.for_seniors(number=1000, organization=nil)
    if organization.nil?
      seniors = where('division_id = ?', "#{Division.find_by_name('seniors').id}").limit(number).to_a
    else
      seniors = where('division_id = ? and organization_id = ?', "#{Division.find_by_name('seniors').id}", organization.id).limit(number).to_a      
    end
      seniors.empty? ? [NullTeam.new] : seniors.sort_by{|t| t.name}
  end

  def self.for_seniorb(number=1000, organization=nil)
    if organization.nil?
      seniorb = where('division_id = ?', "#{Division.find_by_name('seniorb').id}").limit(number).to_a
    else
      seniorb = where('division_id = ? and organization_id = ?', "#{Division.find_by_name('seniorb').id}", organization.id).limit(number).to_a      
    end
      seniorb.empty? ? [NullTeam.new] : seniorb.sort_by{|t| t.name}
  end 

  
  # Methods
  # Returns active teams that are not at capacity in accordance with student's grade and organization
  def self.not_at_capacity(student=nil, organization=nil, division=nil)
    tmp = Array.new
    if student && organization && division #if student, organization and division are provided
      teams = organization.teams.active.alphabetical.for_division(division)
    elsif student && organization && !division #if only student and organization are provided
      gr = student.grade
      divisions_in_range = Division.all.active.where("start_grade <= :g AND end_grade >= :g", {g: gr}).order("id")
      teams = student.current_organization.teams.active.all.select{|t| divisions_in_range.map{ |d| d.id}.include?(t.division_id)}
    else #returns all active teams that are not at capacity 
      teams = Team.active.alphabetical.all
    end
    unless teams.empty? #filters out at capacity teams
      teams.each do |team|
        tmp << team if team.current_students.size < 5
      end    
    end 
    tmp
  end

  #  def self.not_at_capacity(organization=nil, division=nil)
  #   tmp = Array.new
  #   if organization && division #if organization and division are provided
  #     teams = organization.teams.active.alphabetical.for_division(division)
  #   elsif organization && !division #if only organization is provided
  #     teams = organization.teams.active.alphabetical
  #   else
  #     teams = Team.active.alphabetical.all
  #   end
  #   unless teams.empty?
  #     teams.each do |team|
  #       tmp << team if team.current_students.size < 5
  #     end    
  #   end 
  #   tmp
  # end

  def scored_quizzes_this_year
    quizzes = Array.new
    scored_events = QuizYear.new.completed_events
    scored_events.each do |event|
      tmp = event.quizzes.select{|q| q.teams.include?(self)}
      quizzes << tmp
    end
    quizzes.flatten!
  end

  def current_students
    self.student_teams.current.map{|st| st.student}.sort
  end

  private
  def division_is_active_in_system
    if(:division.nil? || :division.blank?)
      self.division = Division.all.where(:id => self.division_id)
    end
    is_active_in_system(:division)
  end

  def organization_is_active_in_system
    is_active_in_system(:organization)
  end

  def verify_that_there_are_no_scored_quizzes_for_team_this_year
    unless self.scored_quizzes_this_year.empty?
      errors.add(:base, "Team cannot be deleted because it has participated in scored quizzes.")
      return false
    end
    return true
  end

end
