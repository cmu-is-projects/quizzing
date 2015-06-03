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

   def self.for_juniors(number=1000)
      juniors = where('division_id = ?', "#{Division.find_by_name('juniors').id}").limit(number).to_a
      juniors.empty? ? [NullTeamStanding.new] : juniors.sort
    end

    def self.for_seniors(number=1000)
      seniors = where('division_id = ?', "#{Division.find_by_name('seniors').id}").limit(number).to_a
      seniors.empty? ? [NullTeamStanding.new] : seniors.sort
    end

    def self.for_seniorb(number=1000)
      seniorb = where('division_id = ?', "#{Division.find_by_name('seniorb').id}").limit(number).to_a
      seniorb.empty? ? [NullTeamStanding.new] : seniorb.sort
    end

  def self.find_topteam(team)
    if team.division.name =="juniors"
      return team.for_juniors.first
    elsif team.division.name =="seniors"
      return team.for_seniors.first
    else return team.for_seniorb.first
  end


end






