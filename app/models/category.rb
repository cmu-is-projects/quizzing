class Category < ActiveRecord::Base

  #Relationships
  belongs_to :quiz
  has_many :quizzes

  validates_presence_of :name
end
