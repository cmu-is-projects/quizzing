class Organization < ActiveRecord::Base
  
  #Relationships
  has_and_belongs_to_many :coaches
  has_and_belongs_to_many :students
  has_one :coach, foreign_key: 'primary_contact';

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
