namespace :db do
  desc "Update the team_standings table in the database"
  task :update_team_standings, [:use_db] => :environment do |t, args|
    db_selected = args[:use_db]
    puts "Database selected: #{db_selected}"
    include DatabaseSwitcher
    verify_database(db_selected)
    connect_to_db(db_selected)

    all_divisions = Division.active.all
    all_divisions.each do |division|
      puts "Team standings for #{division.name}"
      year_teams = YearTeam.get_all_teams_for_division_for_year(division)
      position = 1
      puts "Starting to record team standings (#{year_teams.count} records)"
      year_teams.each do |yr_team|
        standing = TeamStanding.find_or_create_by(team_id: yr_team.team.id)
        standing.position = position
        standing.team_id = yr_team.team.id
        standing.division_id = division.id
        standing.total_points = yr_team.total_points
        standing.accuracy = yr_team.total_accuracy
        if standing.save!
          puts "#{position}. #{yr_team.team.name} standing saved"
        else
          puts "Failed to save standing for #{yr_team.team.name}"
        end
        position += 1
      end
    end
  end
end