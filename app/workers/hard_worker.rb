require_relative '../../lib/database_switcher'
class HardWorker
	include DatabaseSwitcher
	#connect_to_db('pgh')
	include Sidekiq::Worker

  def perform(area)
  	#Rake::Task['db:update_area_standings'].invoke(area)
  	#puts "#{Student.first.student_quizzes.count}"
  	#Rake::Task['test_task']

  	#TODO configure to pass in subdomain from session
  	system "rake db:update_area_standings[#{area}]"
  end
end