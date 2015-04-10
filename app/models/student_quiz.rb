class StudentQuiz < ActiveRecord::Base
  # get module to help with some functionality
  include QuizHelpers::Validations
  include QuizHelpers::IndividualScoring

  belongs_to :student
  belongs_to :quiz

  validate :student_is_active_in_system
  validate :quiz_is_active_in_system

  #Scopes
  #TODO: test
  scope :by_round_num, -> { joins(:quiz).order('round_num') }
  

  before_save :calculate_score

  def self.for_event(event)
    StudentQuiz.joins(:quiz).where('quizzes.event_id = ?', event.id)
  end

  def self.for_student(student)
    StudentQuiz.where(student_id: student.id)
  end

  # not sure if we want this private or not yet...
  def calculate_score
    unless self.num_correct.nil?  || self.num_attempts.nil?
      self.score = calculate_student_quiz_score(self.num_correct, self.num_attempts, self.num_fouls)
    else
      self.score = nil
    end
    self.score
  end

  private
  def student_is_active_in_system
    is_active_in_system(:student)
  end

  def quiz_is_active_in_system
    is_active_in_system(:quiz)
  end
end
