class Organization < ActiveRecord::Base
  # get module to help with some functionality
  include QuizHelpers::Validations
  
  #Relationships
  has_many :coaches
  has_many :organization_students
  has_many :students, through: :organization_students
  has_many :teams

  #Validations
  validates_presence_of :name

  #Scopes
  scope :alphabetical, -> {order("name")}
  scope :active, -> {where(active: true)}
  scope :inactive, -> {where(active: false)}

  #Callbacks
  before_destroy Proc.new {false}

  #Methods
  
  private

end
