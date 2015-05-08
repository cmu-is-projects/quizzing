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

    def create_add_students
      @nate = FactoryGirl.create(:student, first_name: "Nate", last_name: "Davis", grade: 11)
      @dean = FactoryGirl.create(:student, first_name: "Dean", last_name: "Merritt", grade: 7)
      @livie = FactoryGirl.create(:student, first_name: "Livie", last_name: "Cerasuolo", grade: 8)
      @artem = FactoryGirl.create(:student, first_name: "Artem", last_name: "Lawhead", grade: 11)
      @aaron = FactoryGirl.create(:student, first_name: "Aaron", last_name: "Santilli", grade: 7)
      @jayla = FactoryGirl.create(:student, first_name: "Jayla", last_name: "Snider", grade: 7)
      @austin = FactoryGirl.create(:student, first_name: "Austin", last_name: "Elliot", grade: 4)
    end

    def delete_add_students
      @nate.delete
      @dean.delete
      @livie.delete
      @artem.delete
      @aaron.delete
      @jayla.delete
    end

  end
end
