class Organization < ActiveRecord::Base
  # get modules to help with some functionality
  include QuizHelpers::Validations
  include Activeable
  
  #Relationships
  has_many :coaches
  has_many :organization_students
  has_many :students, through: :organization_students
  has_many :teams
  belongs_to :primary_contact, class_name: "Coach", foreign_key: "primary_contact"

  #Validations
  validates_presence_of :name
  # TODO: validating zip/postal codes (handling Canada is the trick...)

  #Scopes
  scope :alphabetical, -> {order("name")}

  # Callbacks
  # before_save :get_organization_coordinates
  before_destroy :is_never_destroyable
  before_update :end_student_tenure_if_organization_made_inactive

  # Methods
  def current_students
    self.organization_students.current.map{|st| st.student}
  end
  
  private
  def end_student_tenure_if_organization_made_inactive
    if !self.active && !self.organization_students.empty?
      current_students = self.organization_students.current.all
      current_students.each do |cs|
        cs.end_date = Date.today
        cs.save!
      end
    end
  end

  def get_organization_coordinates
    return true if self.street_1.nil? || self.zip.nil?
    str = self.street_1
    zip = self.zip
    
    coord = Geocoder.coordinates("#{str}, #{zip}")
    if coord
      self.latitude = coord[0]
      self.longitude = coord[1]
    else 
      errors.add(:base, "Error with geocoding")
    end
    coord
  end

end
