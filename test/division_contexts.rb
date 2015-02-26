module Contexts
  module DivisionContexts
    
    def create_divisions
      @div1 = FactoryGirl.create(:division)
      @div2 = FactoryGirl.create(:division, name: "Senior B")
      @div3 = FactoryGirl.create(:division, name: "Junior")
    end

    def delete_divisions
      @div1.delete
      @div2.delete
      @div3.delete
    end

  end
end
