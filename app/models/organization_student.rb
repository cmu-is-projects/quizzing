class OrganizationStudent < ActiveRecord::Base
  # get module to help with some functionality
  include QuizHelpers::Validations

  belongs_to :organization
  belongs_to :student

  validate :student_is_active_in_system, on: :create
  validate :organization_is_active_in_system, on: :create

  scope :current, -> { where(end_date: nil) }
  scope :for_organization, ->(organization) { where(organization_id: organization.id) }

  private
  def student_is_active_in_system
    is_active_in_system(:student)
  end

  def organization_is_active_in_system
    is_active_in_system(:organization)
  end

end
