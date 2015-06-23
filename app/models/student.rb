class Student < ActiveRecord::Base
  # get modules to help with some functionality
  include QuizHelpers::Validations
  include Activeable
  include PgSearch

  # attr_accessor :team_id

  # pg_search
  pg_search_scope :search_by_name,
                  :against => [:first_name, :last_name],
                  :using =>[:tsearch, :dmetaphone]

  # Relationships
  has_many :student_quizzes
  has_many :quizzes, through: :student_quizzes
  has_many :student_teams
  has_many :teams, through: :student_teams
  has_many :organization_students
  has_many :organizations, through: :organization_students

  has_one :indiv_standing

  # Validations
  validates_presence_of :first_name, :last_name, :grade
  validates_numericality_of :grade, only_integer: true, greater_than: 1, less_than: 13

  # Scopes
  scope :alphabetical, -> {order("last_name, first_name")}  
  
  # Callbacks
  before_destroy :is_never_destroyable
  before_update :remove_from_team_if_student_inactive

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

  def current_student_team
    latest = self.student_teams.where(end_date: nil)
    if latest.empty? || latest.nil?
      return NullStudentTeam.new
    else
      return latest.first
    end
  end

#TODO: this method doesn't work if db is empty
  def self.new_students(organization=nil)
    tmp = Array.new
    newstudents = Array.new
    if organization
      current_students = organization.current_students
      current_students.each do |s| 
        newstudents << s if s.active #how to install it
      end
    else
      newstudents = Student.active.alphabetical
    end
    newstudents.each do |st|
      tmp << st if st.current_team.is_a?(NullTeam)
    end
    tmp
  end

  def add_to_organization(current_user)
    os = OrganizationStudent.new
    os.student_id = self.id
    org_id = Coach.all.where(user_id: current_user.id).first.organization_id
    os.organization_id = org_id
    os.start_date = Date.today
    os.save!
  end

  
  def is_captain?
    latest = self.student_teams.where(end_date: nil)
    if latest.empty? || latest.nil?
      return false
    else
      return latest.to_a.first.is_captain
    end

  end

  private
  def remove_from_team_if_student_inactive
    remove_from_current_team if !self.active
  end


  def remove_from_current_team
    latest = self.student_teams.where(end_date: nil).first
    unless latest.nil?
      latest.end_date = Date.today
      latest.save!
    end
  end
end
