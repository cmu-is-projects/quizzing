class Category < ActiveRecord::Base

  #Relationships
  has_many :quizzes

  validates_presence_of :name
  validates_uniqueness_of :name, case_sensitive: false

  #Scopes
  scope :alphabetical, -> {order("name")}

  #Callbacks
  before_destroy Proc.new {false}

end
