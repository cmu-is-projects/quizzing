class Organization < ActiveRecord::Base
  # get modules to help with some functionality
  include QuizHelpers::Validations

  STATES_LIST = [['Alabama', 'AL'],['Alaska', 'AK'],['Arizona', 'AZ'],['Arkansas', 'AR'],['California', 'CA'],['Colorado', 'CO'],['Connecticut', 'CT'],['Delaware', 'DE'],['District of Columbia ', 'DC'],['Florida', 'FL'],['Georgia', 'GA'],['Hawaii', 'HI'],['Idaho', 'ID'],['Illinois', 'IL'],['Indiana', 'IN'],['Iowa', 'IA'],['Kansas', 'KS'],['Kentucky', 'KY'],['Louisiana', 'LA'],['Maine', 'ME'],['Maryland', 'MD'],['Massachusetts', 'MA'],['Michigan', 'MI'],['Minnesota', 'MN'],['Mississippi', 'MS'],['Missouri', 'MO'],['Montana', 'MT'],['Nebraska', 'NE'],['Nevada', 'NV'],['New Hampshire', 'NH'],['New Jersey', 'NJ'],['New Mexico', 'NM'],['New York', 'NY'],['North Carolina','NC'],['North Dakota', 'ND'],['Ohio', 'OH'],['Oklahoma', 'OK'],['Oregon', 'OR'],['Pennsylvania', 'PA'],['Rhode Island', 'RI'],['South Carolina', 'SC'],['South Dakota', 'SD'],['Tennessee', 'TN'],['Texas', 'TX'],['Utah', 'UT'],['Vermont', 'VT'],['Virginia', 'VA'],['Washington', 'WA'],['West Virginia', 'WV'],['Wisconsin ', 'WI'],['Wyoming', 'WY']]

  include Activeable

  #Relationships
  has_many :coaches
  has_many :organization_students
  has_many :students, through: :organization_students
  has_many :teams
  has_many :events
  belongs_to :primary_contact, class_name: "Coach", foreign_key: "primary_contact"

  #Validations
  validates :name, presence: true
  validates :state, inclusion: { in: (STATES_LIST.map{|a,b| a} + STATES_LIST.map { |a,b| b }), message: "is not valid state", allow_blank: true }
  #case 1 - if street_1 entered, need a zip to geocode
  validates :zip, presence: true, unless: "street_1.nil?"
  #case 2 - if zip entered, need street 1 to geocode
  validates :street_1, presence: true, unless: "zip.nil?"
  #case 3 - if state is entered - if a zip is entered with it - the zip needs to be 5 digits 
  #and continue to discern the allow_blank...
  validates :zip, format: { with: /\A\d{5}\z/, message: "should be five digits long because an American state was provided", allow_blank: true }, if: :zip_and_state_entered?
  #case 5 - if zip is entered without a state, the zip should then be of Canadian format
  validates :zip, format: { with: /\A[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1}[ -]?\d{1}[A-Z]{1}\d{1}\z/, message: "The zip you entered should be of Canadian format because you did not enter a US state", allow_blank: true }, if: :zip_is_entered_without_a_state?
  
  #Scopes
  scope :alphabetical, -> {order("name")}
  scope :active, -> {where(active: true)}
  scope :inactive, -> {where(active: false)}
  
  #Callbacks
  # before_save :get_organization_coordinates

  before_destroy :is_never_destroyable
  before_update :end_student_tenure_if_organization_made_inactive
  #before_validation :set_street_2_to_blank

  # Methods
  def current_students
    self.organization_students.current.map{|st| st.student}
  end
  
  private
  #TODO - test
  def zip_and_state_entered?
    return ( !self.zip.nil? && !self.state.nil? )
  end

  def zip_is_entered_without_a_state?
    return ( !self.zip.nil? && self.state.nil? )
  end

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

  # def set_street_2_to_blank
  #   if self.street_1.blank? and self.street_2
  #     self.street_2 = ""
  #     self.street_2.save!
  #   end
  # end

end #class
