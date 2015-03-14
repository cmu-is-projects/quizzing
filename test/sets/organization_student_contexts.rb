module Contexts
  module OrganizationStudentContexts
    # assumes create_students and create_organizations method already run...
    def create_acac_students
      @mark_acac       = FactoryGirl.create(:organization_student, student: @mark, organization: @acac, start_date: 3.years.ago.to_date)
      @alex_acac       = FactoryGirl.create(:organization_student, student: @alex, organization: @acac, start_date: 3.years.ago.to_date)
      @amanda_acac     = FactoryGirl.create(:organization_student, student: @amanda, organization: @acac, start_date: 2.years.ago.to_date)
      @jonathon_acac   = FactoryGirl.create(:organization_student, student: @jonathan, organization: @acac, start_date: 1.year.ago.to_date)
      @quincy_acac     = FactoryGirl.create(:organization_student, student: @quincy, organization: @acac, start_date: 3.years.ago.to_date, end_date: 1.year.ago.to_date)
    end

    def delete_acac_students
      @mark_acac.delete
      @alex_acac.delete
      @amanda_acac.delete
      @jonathon_acac.delete
      @quincy_acac.delete
    end

    def create_organization_students
      create_acac_students
      @quincy_somerset = FactoryGirl.create(:organization_student, student: @quincy, organization: @somerset, start_date: 1.year.ago.to_date)
      @mindy_somerset  = FactoryGirl.create(:organization_student, student: @mindy, organization: @somerset, start_date: 3.years.ago.to_date)
      @jimmy_somerset  = FactoryGirl.create(:organization_student, student: @jimmy, organization: @somerset, start_date: 3.years.ago.to_date)
    end

    def delete_organization_students
      delete_acac_students
      @quincy_somerset.delete
      @mindy_somerset.delete
      @jimmy_somerset.delete
    end

  end
end