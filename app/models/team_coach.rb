class TeamCoach < ActiveRecord::Base
  # get module to help with some functionality
  include QuizHelpers::Validations

  belongs_to :team
  belongs_to :coach

  validate :coach_is_active_in_system
  validate :team_is_active_in_system

  private
  def coach_is_active_in_system
    is_active_in_system(:coach)
  end

  def team_is_active_in_system
    is_active_in_system(:team)
  end
end
