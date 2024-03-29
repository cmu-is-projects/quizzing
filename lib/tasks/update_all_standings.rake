namespace :db do
  desc "Update the standings tables for all databases in the system"
  task :update_all_standings => :environment do
    # Iterate through list of databases to test if updates needed
    # all_dbs = SETTINGS[:database_list]
    all_dbs = ['pgh', 'pnw']

    all_dbs.each do |db_selected|
      # Update individual standings
      Rake::Task['db:update_indiv_standings'].invoke(db_selected)

      # Update team standings
      Rake::Task['db:update_team_standings'].invoke(db_selected)

      # Update event summaries
      Rake::Task['db:update_event_summaries'].invoke(db_selected)  
    end
  end
end

