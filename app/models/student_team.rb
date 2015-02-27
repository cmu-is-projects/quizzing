class StudentTeam < ActiveRecord::Base
  # get module to help with some functionality
  include QuizHelpers::Validations

  belongs_to :student
  belongs_to :team

  scope :is_captain, -> {where(captain: true)}

  private
  def student_is_active_in_system
    is_active_in_system(:student)
  end

  def team_is_active_in_system
    is_active_in_system(:team)
  end
end
