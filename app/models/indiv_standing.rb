class IndivStanding < ActiveRecord::Base
	# Validations
	validates_numericality_of :position, only_integer: true, greater_than: 0, less_than: 100
	validates_numericality_of :student_id, only_integer: true, greater_than: 0
	validates_numericality_of :current_team, only_integer: true, greater_than: 0
	validates_numericality_of :total_points, only_integer: true, greater_than: 0
end
