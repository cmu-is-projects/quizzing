module Contexts
  module UserContexts
    
    def create_users
      @user1 = FactoryGirl.create(:user, user_name: "Lankly", role: "area_admin")
      @user2 = FactoryGirl.create(:user, user_name: "ProfH", role: "admin")
      @user3 = FactoryGirl.create(:user, user_name: "Coach1")
      @user4 = FactoryGirl.create(:user, user_name: "InactiveCoach", active: false)
    end

    def delete_users
      @user1.delete unless @user1.nil?
      @user2.delete unless @user2.nil?
      @user3.delete unless @user3.nil?
      @user4.delete unless @user4.nil?
    end
  end
end
