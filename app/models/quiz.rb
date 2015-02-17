class Quiz < ActiveRecord::Base

  #Relationships
  belongs_to :events
  has_and_belongs_to_many :students
  has_and_belongs_to_many :teams
  has_one :division

  #Validations
  validates_presence_of :event_id, :division_id 
  validates_numericality_of :round_num, only_integer: true, greater_than: 0

  #Scopes
  scope :active, -> {where(active: true)}
  scope :inactive, -> {where(active: false)}

  #Callbacks
  before_destroy Proc.new {false}

  #Methods

  private

end
