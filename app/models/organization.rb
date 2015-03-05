class Organization < ActiveRecord::Base
  # get module to help with some functionality
  include QuizHelpers::Validations
  STATES_LIST = [['Alabama', 'AL'],['Alaska', 'AK'],['Arizona', 'AZ'],['Arkansas', 'AR'],['California', 'CA'],['Colorado', 'CO'],['Connectict', 'CT'],['Delaware', 'DE'],['District of Columbia ', 'DC'],['Florida', 'FL'],['Georgia', 'GA'],['Hawaii', 'HI'],['Idaho', 'ID'],['Illinois', 'IL'],['Indiana', 'IN'],['Iowa', 'IA'],['Kansas', 'KS'],['Kentucky', 'KY'],['Louisiana', 'LA'],['Maine', 'ME'],['Maryland', 'MD'],['Massachusetts', 'MA'],['Michigan', 'MI'],['Minnesota', 'MN'],['Mississippi', 'MS'],['Missouri', 'MO'],['Montana', 'MT'],['Nebraska', 'NE'],['Nevada', 'NV'],['New Hampshire', 'NH'],['New Jersey', 'NJ'],['New Mexico', 'NM'],['New York', 'NY'],['North Carolina','NC'],['North Dakota', 'ND'],['Ohio', 'OH'],['Oklahoma', 'OK'],['Oregon', 'OR'],['Pennsylvania', 'PA'],['Rhode Island', 'RI'],['South Carolina', 'SC'],['South Dakota', 'SD'],['Tennessee', 'TN'],['Texas', 'TX'],['Utah', 'UT'],['Vermont', 'VT'],['Virginia', 'VA'],['Washington', 'WA'],['West Virginia', 'WV'],['Wisconsin ', 'WI'],['Wyoming', 'WY']]

  #Relationships
  has_many :coaches
  has_many :organization_students
  has_many :students, through: :organization_students
  has_many :teams
  has_many :events

  #Validations
  #will next turn street_1 and zip into dependent conditionals 
  validates_presence_of :name #,:street_1, :zip
  validates_uniqueness_of :name, case_sensitive: false
  validates :primary_contact, presence: true, numericality: { only_integer: true, greater_than: 0, allow_blank: false }
  validates :state, inclusion: { in: STATES_LIST.map{|a,b| b}, message: "is not valid state", allow_blank: true }
  #discern allow_blank for below after connecting it with street_1
  validates :zip, format: { with: /\A\d{5}\z/, message: "should be five digits long", allow_blank: true }

  #custom validations
  #not sure if need
  # validate :primary_contact_is_active_in_system

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

  #unsure of how to do
  # def primary_contact_is_active_in_system
  #   is_active_in_system(:)
  # end

end
