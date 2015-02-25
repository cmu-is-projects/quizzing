class OrganizationStudent < ActiveRecord::Base
  # get module to help with some functionality
  include QuizHelpers::Validations

  belongs_to :organization
  belongs_to :student

  private
  def student_is_active_in_system
    is_active_in_system(:student)
  end

  def organization_is_active_in_system
    is_active_in_system(:organization)
  end

end
