namespace :db do
  desc "Update the standings tables in the database"
  task :update_standings => :environment do

    # Iterate through list of databases to test if updates needed
    include DatabaseSwitcher
    db_selected = 'pgh'
    if connect_to_db(db_selected)
      puts "Connected to #{db_selected}"
    else
      puts "Not connected to #{db_selected}"
    end

    # Update individual standings
    all_divisions = Division.active.all
    all_divisions.each do |division|
      puts "Individual standings for #{division.name}"
      year_quizzers = YearQuizzer.get_all_quizzers_for_division_for_year(division)
      position = 1
      puts "Starting ... #{year_quizzers.count} records"
      year_quizzers.each do |student|
        standing = IndivStanding.find_or_create_by(student_id: student.quizzer.id)
        standing.position = position
        standing.student_id = student.quizzer.id
        standing.team_id = student.team.id
        standing.division_id = division.id
        standing.total_points = student.total_points
        standing.lowest_score = student.lowest_points
        standing.adjusted_points = student.adjusted_points
        standing.accuracy = student.total_accuracy
        if standing.save!
          puts "#{position}. #{student.quizzer.name} standing saved"
        else
          puts "Failed to save standing for #{student.quizzer.name}"
        end
        position += 1
      end
    end



  end
end

