module Contexts
  module CategoryContexts
    
    def create_categories
      @category1 = FactoryGirl.create(:category)
      @category2 = FactoryGirl.create(:category, name: "Category Two")
      @category_inactive = FactoryGirl.create(:category, name: "Category Inactive")
    end

    def delete_categories
      @category1.delete
      @category2.delete
      @category_inactive.delete
    end

  end
end
