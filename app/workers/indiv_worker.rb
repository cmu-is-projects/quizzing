require_relative '../../lib/database_switcher'
class IndivWorker
	include DatabaseSwitcher
	#connect_to_db('pgh')
	include Sidekiq::Worker

  def perform(area)
  	system "rake db:update_indiv_standings[#{area}]"
  end
end