class Organization < ActiveRecord::Base
  # get module to help with some functionality
  include QuizHelpers::Validations
  
  #Relationships
  has_many :coaches
  has_many :organization_students
  has_many :students, through: :organization_students
  has_many :teams
  has_many :events

  #Validations
  validates_presence_of :name

  #Scopes
  scope :alphabetical, -> {order("name")}
  scope :active, -> {where(active: true)}
  scope :inactive, -> {where(active: false)}

  #Callbacks
  before_destroy Proc.new {false}
  before_save :find_coordinates
  
  #Methods
  private
  def find_coordinates
    return nil if (self.name.nil? || self.state.nil?)
    coords = Geocoder.coordinates(self.street_1+", "+self.zip)
    #first index of coordinates
    self.latitude = coords[0]
    #second index of coordinates
    self.longitude = coords[1]
    coords
  end

end
