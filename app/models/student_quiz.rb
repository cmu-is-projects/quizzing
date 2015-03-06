class StudentQuiz < ActiveRecord::Base
  # get module to help with some functionality
  include QuizHelpers::Validations

  belongs_to :student
  belongs_to :quiz

  validate :student_is_active_in_system
  validate :quiz_is_active_in_system

  private
  def student_is_active_in_system
    is_active_in_system(:student)
  end

  def quiz_is_active_in_system
    is_active_in_system(:quiz)
  end
end
