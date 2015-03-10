module Contexts
  module DivisionContexts
    
    # used for setting up other contexts 
    def create_one_division
      @senior_a = FactoryGirl.create(:division)
    end

    def delete_one_division
      @senior_a.delete
    end
    
    def create_divisions
      create_one_division
      @senior_b = FactoryGirl.create(:division, name: "Senior B", active: false)
      @junior   = FactoryGirl.create(:division, name: "Junior", start_grade: 3, end_grade: 6)
    end

    def delete_divisions
      delete_one_division
      @senior_b.delete
      @junior.delete
    end



  end
end
