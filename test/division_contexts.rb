module Contexts
  module DivisionContexts
    
    def create_divisions
      @div1 = FactoryGirl.create(:division)
      @div2 = FactoryGirl.create(:division, name: "Senior B")
      @div3 = FactoryGirl.create(:division, name: "Junior")
    end

    def delete_divisions
      @div1.delete unless @div1.nil?
      @div2.delete unless @div2.nil?
      @div3.delete unless @div3.nil?
    end

  end
end
