module Contexts
  module UserContexts
    
    def create_users
      @user1 = FactoryGirl.create(:user, username: "Lankly", role: "area_admin")
      @user2 = FactoryGirl.create(:user, username: "ProfH", role: "admin")
      @user3 = FactoryGirl.create(:user, username: "Coach1")
      @user4 = FactoryGirl.create(:user, username: "Coach2")
      @user5 = FactoryGirl.create(:user, username: "InactiveCoach", active: false)
    end

    def delete_users
      @user1.delete
      @user2.delete
      @user3.delete
      @user4.delete
      @user5.delete
    end

    def create_extra_users
      @user6 = FactoryGirl.create(:user, username: "tomreay")
    end

    def delete_extra_users
      @user6.delete      
    end
  end
end
