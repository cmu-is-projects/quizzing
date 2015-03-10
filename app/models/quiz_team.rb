class QuizTeam < ActiveRecord::Base
  # get module to help with some functionality
  include QuizHelpers::Validations

  belongs_to :team
  belongs_to :quiz

  validate :quiz_is_active_in_system
  validate :team_is_active_in_system

  # TODO: Need to calculate points from raw scores, challenges, and fouls

  private
  def quiz_is_active_in_system
    is_active_in_system(:quiz)
  end

  def team_is_active_in_system
    is_active_in_system(:team)
  end
end
