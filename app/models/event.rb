class Event < ActiveRecord::Base
  include QuizHelpers::Validations

  #Relationships
  has_many :quizzes
  belongs_to :organization
  has_one :event_summary

  #Validations
  validates_presence_of :start_date, :end_date, :start_time, :num_rounds
  validates_time :start_time
  validates_date :start_date, :on_or_after => lambda { Date.today }, :on_or_after_message => "cannot be in the past", on: :create
  validates_date :end_date, :on_or_after => :start_date, :on_or_after_message => "cannot end before beginning"
  validates_numericality_of :num_rounds, only_integer: true, greater_than: 0
  validate :organization_is_active_in_system

  #Scopes
  scope :chronological, -> { order("start_date", "end_date") }
  scope :upcoming,      -> { where("start_date >= ?", Date.today) }
  scope :past,          -> { where("end_date <= ?", Date.today) }

  private
  def organization_is_active_in_system
    is_active_in_system(:organization)
  end

end
