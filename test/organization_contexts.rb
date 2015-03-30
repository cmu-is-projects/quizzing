module Contexts
  module OrganizationContexts
    
    def create_organizations
      @organization1 = FactoryGirl.create(:organization)
      # sleep 1
      @organization2 = FactoryGirl.create(:organization, name: "Organization Two", primary_contact: 2)
      # sleep 1
      @organization_inactive = FactoryGirl.create(:organization, name: "Organization Inactive", primary_contact: 3, active: false)
      # sleep 1
    end
    
    def delete_organizations
      @organization1.delete unless @organization1.nil?
      @organization2.delete unless @organization2.nil?
      @organization_inactive.delete unless @organization_inactive.nil?
    end

  end
end
