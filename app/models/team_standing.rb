class TeamStanding < ActiveRecord::Base

		# Validations
        validates_presence_of :position, :team_id, :total_points, :accuracy

        validates_numericality_of :position, only_integer: true, greater_than: 0, less_than: 100
        validates_numericality_of :team_id, only_integer: true, greater_than: 0
        validates_numericality_of :total_points, only_integer: true, greater_than: 0
        validates_numericality_of :accuracy, less_than: 1.01

        # Scopes
        scope :by_position, -> { order(:position) }
        scope :for_juniors, -> { where('division_id = ?', "#{Division.find_by_name('juniors').id}") }
        scope :for_seniors, -> { where('division_id = ?', "#{Division.find_by_name('seniors').id}") }
        scope :for_seniorb, -> { where('division_id = ?', "#{Division.find_by_name('seniorb').id}") }
end