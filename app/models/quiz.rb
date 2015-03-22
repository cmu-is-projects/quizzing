class Quiz < ActiveRecord::Base
  # get modules to help with some functionality
  include QuizHelpers::Validations
  include Activeable

  #Relationships
  belongs_to :event
  has_many :student_quizzes
  has_many :students, through: :student_quizzes
  has_many :quiz_teams
  has_many :teams, through: :quiz_teams
  belongs_to :category
  belongs_to :division

  #Validations
  validates_presence_of :event_id, :division_id, :round_num
  validates_numericality_of :event_id, :division_id, :round_num, :room_num, only_integer: true, greater_than: 0

  #custom validation
  # validate :ensure_quiz_is_for_current_event

  #Scopes
  scope :active, -> {where(active: true)}
  scope :inactive, -> {where(active: false)}
  #consider scope "by_round"

  #Callbacks
  validate :event_is_active_in_system
  validate :division_is_active_in_system

  # Callbacks
  # before_destroy :verify_that_the_quiz_has_no_scores

  #need method to ensure uniqueness of event, division, round uniqueness
  
  #Methods

  private
  def event_is_active_in_system
    is_active_in_system(:event)
  end

  def division_is_active_in_system
    is_active_in_system(:division)
  end

  #need to ensure quiz can't be assigned to past event
  # def ensure_quiz_is_for_past_event
  #   return false if self.event.start_date < Date.today
  #   return true       
  # end

  # TODO: write this method and test
  # def verify_that_the_quiz_has_no_scores
     
  # end

end
