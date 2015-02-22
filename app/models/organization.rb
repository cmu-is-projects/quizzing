class Organization < ActiveRecord::Base
  
  #Relationships
  has_many :coaches
  has_many :organization_students
  has_many :students, through: :organization_students

  #Validations
  # validates_presence_of :name

  # #Scopes
  # scope :alphabetical, -> {order("name")}
  # scope :active, -> {where(active: true)}
  # scope :inactive, -> {where(active: false)}

  # #Callbacks
  # before_destroy Proc.new {false}

  # #Methods
  
  # private

end
