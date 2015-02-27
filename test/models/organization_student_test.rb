require 'test_helper'

class OrganizationStudentTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:organization)
  should belong_to(:student)
end
