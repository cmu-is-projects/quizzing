class OrganizationStudent < ActiveRecord::Base
  belongs_to :organization
  belongs_to :student
end
