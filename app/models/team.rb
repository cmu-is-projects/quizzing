class Team < ActiveRecord::Base

  #Relationships
  belongs_to :organization
  belongs_to :division
  has_many :student_teams
  has_many :students, through: :student_teams
  has_many :quiz_teams
  has_many :quizzes, through: :quiz_teams
  has_many :coaches


  #Validations
  validates_presence_of :division_id, :name
  
  #Scopes
  scope :alphabetical, -> {order("name")}
  scope :active, -> {where(active: true)}
  scope :inactive, -> {where(active: false)}

  #Callbacks
  before_destroy Proc.new {false}

  #Methods

  private

end
