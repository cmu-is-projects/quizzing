class Category < ActiveRecord::Base

  #Relationships
  has_many :quizzes
end
