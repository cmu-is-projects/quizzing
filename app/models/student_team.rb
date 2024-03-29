class StudentTeam < ActiveRecord::Base
  # get modules to help with some functionality
  include QuizHelpers::Validations
  # include Activeable

  belongs_to :student
  belongs_to :team

  scope :is_captain, -> { where(is_captain: true) }
  scope :current,    -> { where(end_date: nil) }
  scope :for_date,   ->(date) { where("start_date <= ? AND (end_date >= ? OR end_date IS NULL)", date, date) }
  scope :for_quiz_year, ->(year) { where("id not in (select id from student_teams st1 where (st1.start_date <= ? and st1.end_date <= ?) or (st1.start_date >= ?))", year.start_date, year.start_date, year.end_date) }
  scope :present, -> { where(present: true) }
  scope :absent,  -> { where(present: false) }
  scope :by_seat, -> { order(:seat) }

  accepts_nested_attributes_for :student

  validates_presence_of :student_id, :team_id
  validate :student_is_active_in_system
  validate :team_is_active_in_system

  before_create :remove_student_from_previous_team_assignment

  private
  def student_is_active_in_system
    is_active_in_system(:student)
  end

  def team_is_active_in_system
    is_active_in_system(:team)
  end

  def remove_student_from_previous_team_assignment
    previous_assignment = self.student.student_teams.where(end_date: nil).first
    return true if previous_assignment.nil?
    previous_assignment.end_date = Date.today
    previous_assignment.save!
    true
  end


end
