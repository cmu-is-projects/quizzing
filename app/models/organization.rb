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
  #TODO: turn street_1 and zip into dependent conditionals 
  validates :name, presence: true
  #validates :street_1, presence: true, unless: "zip.nil?"
  validates_uniqueness_of :name, case_sensitive: false
  validates :state, inclusion: { in: (STATES_LIST.map{|a,b| a} + STATES_LIST.map { |a,b| b }), message: "is not valid state", allow_blank: true }
  #discern allow_blank for below after connecting it with street_1
  validates :zip, format: { with: /\A\d{5}\z/, message: "should be five digits long", allow_blank: true }
  #validates :zip, presence: true, unless: "street_1.nil?"
  

  # TODO: validating zip/postal codes (handling Canada is the trick...)
  
  #Scopes
  scope :alphabetical, -> {order("name")}
  
  #Callbacks
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

end #class
