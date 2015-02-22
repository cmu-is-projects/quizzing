class Coach < ActiveRecord::Base

  #Relationships
  belongs_to :users
  has_and_belongs_to_many :organizations
  has_many :teams

  #Validations 
  validates_presence_of :user_id, :first_name, :last_name
  validate :user_is_active_in_system

  #Scopes
  scope :alphabetical, -> {order("last_name","first_name")}
  
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
