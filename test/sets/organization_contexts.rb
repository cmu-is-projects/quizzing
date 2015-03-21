module Contexts
  module OrganizationContexts
    
    # for use with other contexts/tests
    def create_one_organization
      @acac = FactoryGirl.create(:organization)
<<<<<<< HEAD
      # sleep 1
=======
      #sleep 1
>>>>>>> 9f0f1a260811fd118f0f3fa9a9e7aac7a480286a
    end

    def delete_one_organization
      @acac.delete
    end

    def create_organizations
      create_one_organization
      # sleep 1
      @somerset = FactoryGirl.create(:organization, name: "Somerset Alliance Church", short_name: "Somerset")
<<<<<<< HEAD
      # sleep 1
      @grove_city = FactoryGirl.create(:organization, name: "Grove City Church", short_name: "Grove City", active: false)
      # sleep 1
=======
      #sleep 1
      @grove_city = FactoryGirl.create(:organization, name: "Grove City Church", short_name: "Grove City", active: false)
      #sleep 1
>>>>>>> 9f0f1a260811fd118f0f3fa9a9e7aac7a480286a
    end
    
    def delete_organizations
      delete_one_organization
      @somerset.delete
      @grove_city.delete
    end

  end
end
