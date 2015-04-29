module Contexts
  module OrganizationContexts
    
    # for use with other contexts/tests
    def create_one_organization
      @acac = FactoryGirl.create(:organization)
      #sleep 1
    end

    def delete_one_organization
      @acac.delete
    end

    def create_organizations
      create_one_organization
      #sleep 1
      @somerset = FactoryGirl.create(:organization, name: "Somerset Alliance Church", short_name: "Somerset")
      # sleep 1
      @grove_city = FactoryGirl.create(:organization, name: "Grove City Church", short_name: "Grove City", active: false)
      #sleep 1
    end
    
    def delete_organizations
      delete_one_organization
      @somerset.delete
      @grove_city.delete
    end

  end
end
