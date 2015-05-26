class IndivStanding < ActiveRecord::Base
        # Validations

        validates_presence_of :position, :student_id, :current_team, :total_points, :lowest_score, :adjusted_points, :accuracy

        validates_numericality_of :position, only_integer: true, greater_than: 0, less_than: 100
        validates_numericality_of :student_id, only_integer: true, greater_than: 0
        validates_numericality_of :current_team, only_integer: true, greater_than: 0
        validates_numericality_of :total_points, only_integer: true, greater_than: 0
        validates_numericality_of :lowest_score, only_integer: true, greater_than: 0
        validates_numericality_of :adjusted_points, only_integer: true, greater_than: 0
        validates_numericality_of :accuracy, less_than: 1.01

        # Scopes
        scope :for_juniors, -> { joins(:divisions).where('divisions.name = ?', 'juniors') }
        scope :for_seniors, -> { joins(:divisions).where('divisions.name = ?', 'seniors') }
        scope :for_seniorb, -> { joins(:divisions).where('divisions.name = ?', 'senior_b') }

end