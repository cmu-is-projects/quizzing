namespace :db do
  desc "Update the standings tables for a particular area"
  task :update_area_standings, [:subdomain] => :environment do |t, args|
    # Identify the database for the area
    db_selected = args[:subdomain]
 
    unless db_selected.nil?
      # Update individual standings
      Rake::Task['db:update_indiv_standings'].invoke(db_selected)

      # Update team standings
      Rake::Task['db:update_team_standings'].invoke(db_selected)  
    end

  end
end