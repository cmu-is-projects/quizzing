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
  validates_presence_of :event_id, :division_id, :round_num, :category_id
  validates_numericality_of :event_id, :division_id, :round_num, :room_num, only_integer: true, greater_than: 0

  #Scopes
  scope :for_division, ->(division){where(division_id: division.id) }
  scope :by_round_and_room, -> { order("round_num, room_num") }

  #Callbacks
  validate :event_is_active_in_system
  validate :division_is_active_in_system

  # Callbacks
  before_destroy :verify_that_the_quiz_has_no_scores

  # Methods

  private
  def event_is_active_in_system
    is_active_in_system(:event)
  end

  def division_is_active_in_system
    is_active_in_system(:division)
  end

  def verify_that_the_quiz_has_no_scores
    student_quizzes.each do |sq| 
      if sq.score != 0
        return false;
      end
    end
    return true;
  end

end #class
