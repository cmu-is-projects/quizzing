class User < ActiveRecord::Base
  # get module to help with some functionality
  include QuizHelpers::Validations

  ROLES = ["admin","area_admin","coach"]

  #Relationships
  has_one :coach
  
  #Validations
  validates_presence_of :user_name, :role, :password_hash, :password_salt
  validates :user_name, uniqueness: true

  #This validation will not work until the method is created 
  validate :role_is_valid
  validates :user_name, uniqueness: true, on: :create

  #Scopes
  scope :alphabetical, -> {order("user_name")}
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  #Callbacks
  before_destroy Proc.new {false}

  #Methods

  def role_is_valid
    if(!ROLES.include?(self.role))
      errors.add(:role, "is an invalid role");
    end
  end
  
  private

#  def user_is_active_in_system
#    all_usr_ids = User.active.map(&:id)
#    unless all_usr_ids.include?(self.user_id)
#      errors.add(:user, "is not an active user in the system");
#    end
#  end

end
