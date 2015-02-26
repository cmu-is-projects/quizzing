class Coach < ActiveRecord::Base
  # get module to help with some functionality
  include QuizHelpers::Validations

  #Relationships
  belongs_to :user  # note that singular relation needs to be written as singular
  belongs_to :organization
  has_many :team_coaches
  has_many :teams, through: :team_coaches

  # Allow user to be nested within coach
  accepts_nested_attributes_for :user, reject_if: ->(user) { user[:username].blank? }, allow_destroy: true


  #Validations 
  validates_presence_of :user_id, :first_name, :last_name
  validates_format_of :phone, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/, message: "should be 10 digits (area code needed) and delimited with dashes only"
  validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format"
  #validate :user_is_active_in_system

  # #Scopes
  # scope :alphabetical, -> {order("last_name","first_name")}
  
  # #Callbacks
  # before_destroy Proc.new {false}

  # #Methods

  # def name
  #   return "#{last_name}, #{first_name}"
  # end

  # def proper_name
  #   return "#{first_name} #{last_name}"
  # end

  private
  def organization_is_active_in_system
    is_active_in_system(:organization)
  end

  # def user_is_active_in_system
  #   is_active_in_system(:user)
  # end

end
