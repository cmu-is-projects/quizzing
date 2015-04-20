class User < ActiveRecord::Base
  rolify
  # get modules to help with some functionality
  include QuizHelpers::Validations
  include Activeable

  # Use built-in rails support for password protection
  has_secure_password

  ROLES = ["admin","area_admin","coach"]

  #Relationships
  has_one :coach
  
  #Validations
  validates_presence_of :user_name, :role
  validates :user_name, uniqueness: { case_sensitive: false}
  validates_presence_of :password, on: :create 
  validates_presence_of :password_confirmation, on: :create 
  validates_confirmation_of :password, on: :create, message: "does not match"
  validates_length_of :password, minimum: 4, message: "must be at least 4 characters long", allow_blank: true
  validate :role_is_valid

  #Scopes
  scope :alphabetical, -> {order("user_name")}

  #Callbacks
  before_destroy :is_never_destroyable
  before_save :downcase_user_name

  #Methods
  def downcase_user_name
    self.user_name = self.user_name.downcase
  end

  def self.authenticate(user_name,password)
    find_by_user_name(user_name.downcase).try(:authenticate, password)
  end

  def role?(authorized_role)
    return false if role.nil?
    role.downcase.to_sym == authorized_role
  end

  def humanize_role
    case self.role
    when "admin"
      "Administrator"
    when "area_admin"
      "Area Administrator"
    else
      "Coach"
    end
  end

  def is_admin?
    return true if self.role == 'admin'
    false
  end

  def is_area_admin?
    return true if self.role == 'area_admin'
    false
  end

  def is_coach?
    return true if self.role == 'coach'
    false
  end

  private
  def role_is_valid
    if(!ROLES.include?(self.role))
      errors.add(:role, "is an invalid role");
    end
  end

end
