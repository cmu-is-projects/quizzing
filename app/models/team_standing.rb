class TeamStanding < ActiveRecord::Base

        # Relationships
        belongs_to :teams


        validates_presence_of :position, :team_id, :total_points, :accuracy

        validates_numericality_of :position, only_integer: true, greater_than: 0, less_than: 100
        validates_numericality_of :team_id, only_integer: true, greater_than: 0
        validates_numericality_of :total_points, only_integer: true, greater_than: 0
        validates_numericality_of :accuracy, less_than: 1.01

        # Scopes
        scope :for_division, -> { joins(:teams).where('teams.division_id = ?', 1) }
        #scope :for_division, -> { includes(teams:[:division] )}
end