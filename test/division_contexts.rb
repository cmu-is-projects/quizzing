module Contexts
  module DivisionContexts
    
    def create_divisions
      @division1 = FactoryGirl.create(:division)
      @division2 = FactoryGirl.create(:division, name: "Senior B")
      @division3 = FactoryGirl.create(:division, name: "Junior")
    end

    def delete_divisions
      @division1.delete
      @division2.delete
      @division3.delete
    end

  end
end
