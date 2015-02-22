class QuizTeam < ActiveRecord::Base
  # get module to help with some functionality
  include QuizHelpers::Validations

  belongs_to :team
  belongs_to :quiz

  private
  def quiz_is_active_in_system
    is_active_in_system(:quiz)
  end

  def team_is_active_in_system
    is_active_in_system(:team)
  end
end
