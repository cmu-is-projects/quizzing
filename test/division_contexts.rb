module Contexts
  module DivisionContexts
    
    def create_divisions
      @division1 = FactoryGirl.create(:division)
      @division2 = FactoryGirl.create(:division, name: "Senior B")
      @division_inactive = FactoryGirl.create(:division, name: "Junior", active: false)
    end

    def delete_divisions
      @division1.delete
      @division2.delete
      @division_inactive.delete
    end

  end
end
