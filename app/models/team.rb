class Team < ActiveRecord::Base

  #Relationships
  has_and_belongs_to_many :students
  has_and_belongs_to_many :quizzes
  has_one :coach

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
