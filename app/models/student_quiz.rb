class StudentQuiz < ActiveRecord::Base
  # get module to help with some functionality
  include QuizHelpers::Validations

  belongs_to :student
  belongs_to :quiz

  private
  def student_is_active_in_system
    is_active_in_system(:student)
  end

  def quiz_is_active_in_system
    is_active_in_system(:quiz)
  end
end
