class QuizTeam < ActiveRecord::Base
  # get module to help with some functionality
  include QuizHelpers::Validations
  include QuizHelpers::TeamScoring

  belongs_to :team
  belongs_to :quiz

  validate :quiz_is_active_in_system
  validate :team_is_active_in_system

  scope :by_round_num, -> { joins(:quiz).order('round_num') }

  # TODO: Need to calculate points from raw scores, challenges, and fouls
  before_save :calculate_raw_score #TODO: fix; causing an error

  def self.for_event(event)
    QuizTeam.joins(:quiz).where('quizzes.event_id = ?', event.id)
  end

  def self.for_team(team)
    QuizTeam.where(team_id: team.id)
  end

  # not sure if we want this private or not yet...
  #TODO future semester?: write in TeamScoring.rb
  def calculate_raw_score
    #self.team_score = 1000000000000 #actually calculate
    return self.raw_score
    #relic exploratory code below
    # unless self.quiz.student_quizzes.nil?  || self.quiz.student_quizzes.empty?
    #   #Top down; go to TeamScoring.rb
    #   #would be nice to utilize EventTeam's get_all_team_quizzes_for_team_in_this_event
    #   self.team_score = calculate_team_quiz_score(self.quiz.student_quizzes, self.team)
    # else
    #   self.team_score = nil
    # end
    # self.team_score
  end

  private
  def quiz_is_active_in_system
    is_active_in_system(:quiz)
  end

  def team_is_active_in_system
    is_active_in_system(:team)
  end
end
