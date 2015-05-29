class TeamStanding < ActiveRecord::Base

  # Relationships
  belongs_to :team
  belongs_to :division

	# Validations
  validates_presence_of :position, :team_id, :division_id, :total_points, :accuracy

  validates_numericality_of :position, only_integer: true, greater_than: 0, less_than: 100
  validates_numericality_of :team_id, only_integer: true, greater_than: 0
  validates_numericality_of :division_id, only_integer: true, greater_than: 0
  validates_numericality_of :total_points, only_integer: true, greater_than: 0
  validates_numericality_of :accuracy, greater_than_or_equal_to: 0, less_than: 1.01


  def self.for_team(team)
  	ts = where('team_id = ?', team.id).first
  	if ts.nil?
  		return NullTeamStanding.new
  	else
  		return ts
  	end
  end

   def self.for_juniors
      juniors = where('division_id = ?', "#{Division.find_by_name('juniors').id}").to_a
      juniors.empty? ? [NullTeamStanding.new] : juniors.sort
    end

    def self.for_seniors
      seniors = where('division_id = ?', "#{Division.find_by_name('seniors').id}").to_a
      seniors.empty? ? [NullTeamStanding.new] : seniors.sort
    end

    def self.for_seniorb
      seniorb = where('division_id = ?', "#{Division.find_by_name('seniorb').id}").to_a
      seniorb.empty? ? [NullTeamStanding.new] : seniorb.sort
    end

end