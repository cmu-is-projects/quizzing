module Contexts
  module UserContexts
    
    def create_users
      @user1 = FactoryGirl.create(:user, user_name: "Lankly", role: "area_admin")
      @user2 = FactoryGirl.create(:user, user_name: "ProfH", role: "admin")
      @user3 = FactoryGirl.create(:user, user_name: "Coach1")
      @user4 = FactoryGirl.create(:user, user_name: "Coach2")
      @user5 = FactoryGirl.create(:user, user_name: "InactiveCoach", active: false)
    end

    def delete_users
      @user1.delete
      @user2.delete
      @user3.delete
      @user4.delete
      @user5.delete
    end

    def create_extra_users
      @user6 = FactoryGirl.create(:user, user_name: "tomreay")
    end

    def delete_extra_users
      @user6.delete      
    end
  end
end
