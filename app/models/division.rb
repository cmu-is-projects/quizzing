class Division < ActiveRecord::Base
  include QuizHelpers::Validations
  include Activeable

  # Relationships
  has_many :quizzes
  has_many :teams 
  has_many :event_summaries

  # Validations
  validates_presence_of :name
  validates :name, uniqueness: true
  validates_numericality_of :start_grade, only_integer: true, greater_than: 1, less_than: 13
  validates_numericality_of :end_grade, only_integer: true, greater_than: 1, less_than: 13

  # Scopes
  scope :alphabetical, -> {order("name")}

  # Callbacks
  before_destroy :is_never_destroyable

end
