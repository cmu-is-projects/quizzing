class TeamStanding < ActiveRecord::Base
		#TODO write test, null objects


		# Validations
        validates_presence_of :position, :team_id, :division_id, :total_points, :accuracy

        validates_numericality_of :position, only_integer: true, greater_than: 0, less_than: 100
        validates_numericality_of :team_id, only_integer: true, greater_than: 0
        validates_numericality_of :division_id, only_integer: true, greater_than: 0
        validates_numericality_of :total_points, only_integer: true, greater_than: 0
        validates_numericality_of :accuracy, greater_than_or_equal_to: 0, less_than: 1.01

        # Scopes
        scope :by_position, -> { order(:position) }
        scope :for_juniors, -> { where('division_id = ?', "#{Division.find_by_name('juniors').id}") }
        scope :for_seniors, -> { where('division_id = ?', "#{Division.find_by_name('seniors').id}") }
        scope :for_seniorb, -> { where('division_id = ?', "#{Division.find_by_name('seniorb').id}") }

        def self.for_team(team)
        	ts = where('team_id = ?', team.id).first
        	if ts.nil?
        		return null_team_standing.new
        	else
        		return ts
        	end
        end
end