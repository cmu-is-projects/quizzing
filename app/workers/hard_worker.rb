class HardWorker
  include Sidekiq::Worker

  def perform(name, count)
  	Rake::Task['db:update_area_standings'].invoke(area)
  end
end