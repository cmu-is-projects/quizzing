class Student < ActiveRecord::Base
  # get modules to help with some functionality
  include QuizHelpers::Validations
  include Activeable

  attr_accessor :team_id

  # Relationships
  has_many :student_quizzes
  has_many :quizzes, through: :student_quizzes
  has_many :student_teams
  has_many :teams, through: :student_teams
  has_many :organization_students
  has_many :organizations, through: :organization_students

  # Validations
  validates_presence_of :first_name, :last_name, :grade
  validates_numericality_of :grade, only_integer: true, greater_than: 1, less_than: 13

  # Scopes
  scope :alphabetical, -> {order("last_name, first_name")}  
  
  # Callbacks
  before_destroy :is_never_destroyable

  # Methods
  def name
    return "#{last_name}, #{first_name}"
  end

  def proper_name
    return "#{first_name} #{last_name}"
  end

  def current_organization
    latest = self.organization_students.where(end_date: nil)
    if latest.empty? || latest.nil?
      return NullOrganization.new
    else
      return latest.first.organization
    end
  end

  def current_team
    latest = self.student_teams.where(end_date: nil)
    if latest.empty? || latest.nil?
      return NullTeam.new
    else
      return latest.first.team
    end
  end

  def self.new_students(organization=nil)
    tmp = Array.new
    if organization
      newstudents = organization.students.active.alphabetical #how to install it
    else
      newstudents = Student.active.alphabetical
    end
    newstudents.each do |st|
      tmp << st if st.current_team.is_a?(NullTeam)
    end
    tmp
  end

  def is_captain?
    latest = self.student_teams.where(end_date: nil)
    if latest.empty? || latest.nil?
      return false
    else
      return latest.to_a.first.is_captain
    end
  end

end
