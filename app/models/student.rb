class Student < ActiveRecord::Base
  # get module to help with some functionality
  include QuizHelpers::Validations

  #Relationships
  has_many :student_quizzes
  has_many :quizzes, through: :student_quizzes
  has_many :student_teams
  has_many :teams, through: :student_teams
  has_many :organization_students
  has_many :organizations, through: :organization_students

  #Validations
  # validates_presence_of :first_name, :last_name, :grade
  # validates_numericality_of :grade, only_integer: true, greater_than: 1

  # #Scopes
  # scope :alphabetical, -> {order("last_name", "first_name")}
  # scope :active, -> {where(active: true)}
  # scope :inactive, -> {where(active: false)}
  # # scope :is_captain, -> {where(captain: true)}
  # # scope :is_not_captain, -> {where(captain: false)}
  
  # #Callbacks
  # before_destroy Proc.new {false}

  # #Methods

  # def name
  #   return "#{last_name}, #{first_name}"
  # end

  # def proper_name
  #   return "#{first_name} #{last_name}"
  # end

  # private

end
