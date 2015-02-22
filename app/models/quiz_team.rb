class QuizTeam < ActiveRecord::Base
  belongs_to :team
  belongs_to :quiz
end
