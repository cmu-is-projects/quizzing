class Team < ActiveRecord::Base
  # get module to help with some functionality
  include QuizHelpers::Validations

  #Relationships
  belongs_to :organization
  belongs_to :division
  has_many :student_teams
  has_many :students, through: :student_teams
  has_many :quiz_teams
  has_many :quizzes, through: :quiz_teams
  has_many :team_coaches
  has_many :coaches, through: :team_coaches

  #Validations
  validates_presence_of :division_id, :name, :organization_id
  validates_uniqueness_of :name, case_sensitive: false

  #custom validations
  validate :organization_is_active_in_system
  
  #Scopes
  scope :alphabetical, -> {order("name")}
  scope :active, -> {where(active: true)}
  scope :inactive, -> {where(active: false)}

  #Callbacks
  before_destroy Proc.new {false}

  #Methods

  private
  #division currently does not have an active field
  # def division_is_active_in_system
  #   is_active_in_system(:division)
  # end

  def organization_is_active_in_system
    is_active_in_system(:organization)
  end

end
