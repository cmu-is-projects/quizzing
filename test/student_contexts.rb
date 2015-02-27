module Contexts
  module StudentContexts
    
    def create_students
      @stud1 = FactoryGirl.create(:student)
      @stud2 = FactoryGirl.create(:student,first_name: "Jane")
      @stud3 = FactoryGirl.create(:student,first_name: "Long", last_name: "Gone", active: false)
    end

    def delete_students
      @stud1.delete
      @stud2.delete
      @stud3.delete
    end

  end
end
