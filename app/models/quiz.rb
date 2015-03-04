class Quiz < ActiveRecord::Base

  #Relationships
  belongs_to :event
  has_many :student_quizzes
  has_many :students, through: :student_quizzes
  has_many :quiz_teams
  has_many :teams, through: :quiz_teams
  belongs_to :category
  belongs_to :division

  #Validations
  validates_presence_of :event_id, :division_id 
  validates_numericality_of :event_id, :division_id, :round_num, only_integer: true, greater_than: 0

  #Scopes
  scope :active, -> {where(active: true)}
  scope :inactive, -> {where(active: false)}
  #consider scope "by_round"

  #Callbacks
  before_destroy Proc.new {false}

  #need method to ensure uniqueness of event, division, round uniqueness

  #Methods

  private
  # def event_is_active_in_system
  #   is_active_in_system(:event)
  # end

  # def division_is_active_in_system
  #   is_active_in_system(:division)
  # end

end
