require_relative '../../lib/database_switcher'
class TeamWorker
	include DatabaseSwitcher
	#connect_to_db('pgh')
	include Sidekiq::Worker

  def perform(area)
  	system "rake db:update_team_standings[#{area}]"
  end
end