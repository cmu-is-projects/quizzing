class Student < ActiveRecord::Base

  #Relationships
  has_and_belongs_to_many :quizzes
  has_and_belongs_to_many :teams
  has_and_belongs_to_many :organizations

  #Validations
  validates_presence_of :first_name, :last_name, :grade
  validates_numericality_of :grade, only_integer: true, greater_than: 1

  #Scopes
  scope :alphabetical, -> {order("last_name", "first_name")}
  scope :active, -> {where(active: true)}
  scope :inactive, -> {where(active: false)}
  scope :is_captain, -> {where(captain: true)}
  scope :is_not_captain, -> {where(captain: false)}
  
  #Callbacks
  before_destroy Proc.new {false}

  #Methods

  def name
    return "#{last_name}, #{first_name}"
  end

  def proper_name
    return "#{first_name} #{last_name}"
  end

  private

end
