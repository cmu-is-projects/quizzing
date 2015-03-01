class Category < ActiveRecord::Base

  #Relationships
  belongs_to :quiz
  has_many :quizzes
end
