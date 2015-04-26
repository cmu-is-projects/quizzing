class QuizTeam < ActiveRecord::Base
  # get module to help with some functionality
  include QuizHelpers::Validations
  include QuizHelpers::TeamScoring

  belongs_to :team
  belongs_to :quiz

  validate :quiz_is_active_in_system
  validate :team_is_active_in_system

  scope :by_round_num, -> { joins(:quiz).order('round_num') }

  # TODO?: Need to calculate points from raw scores, challenges, and fouls
  before_save :calculate_raw_score

  def self.for_event(event)
    QuizTeam.joins(:quiz).where('quizzes.event_id = ?', event.id)
  end

  def self.for_team(team)
    QuizTeam.where(team_id: team.id)
  end

  # not sure if we want this private or not yet...
  def calculate_raw_score
    return self.raw_score
  end

  private
  def quiz_is_active_in_system
    is_active_in_system(:quiz)
  end

  def team_is_active_in_system
    is_active_in_system(:team)
  end
end
