module Contexts
  module StudentContexts
    
    def create_students
      @mark     = FactoryGirl.create(:student)
      @alex     = FactoryGirl.create(:student, first_name: "Alex")
      @amanda   = FactoryGirl.create(:student, first_name: "Amanda", last_name: "Olbeter")
      @jonathan = FactoryGirl.create(:student, first_name: "Jonathan", last_name: "Cranston", grade: 4)
      @quincy   = FactoryGirl.create(:student, first_name: "Quincy", last_name: "Mix", grade: 7)
      @mindy    = FactoryGirl.create(:student, first_name: "Mindy", last_name: "Douglas", grade: 10)
      @jimmy    = FactoryGirl.create(:student, first_name: "Jimmy", last_name: "Olson", grade: 8)
      @gone     = FactoryGirl.create(:student, first_name: "Long", last_name: "Gone", active: false)
    end

    def delete_students
      @mark.delete
      @alex.delete
      @amanda.delete
      @jonathan.delete
      @quincy.delete
      @mindy.delete
      @jimmy.delete
      @gone.delete
    end

  end
end
