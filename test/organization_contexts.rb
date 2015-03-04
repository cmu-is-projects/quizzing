module Contexts
  module OrganizationContexts
    
    def create_organizations
      @org1 = FactoryGirl.create(:organization)
      sleep 1
      @org2 = FactoryGirl.create(:organization, name: "Org Two", primary_contact: 2)
      sleep 1
      @org_inactive = FactoryGirl.create(:organization, name: "Org Inactive", active: false)
      sleep 1
    end
    
    def delete_organizations
      @org1.delete unless @org1.nil?
      @org2.delete unless @org2.nil?
      @org_inactive.delete unless @org_inactive.nil?
    end

  end
end
