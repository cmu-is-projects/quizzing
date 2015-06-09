namespace :db do
  desc "Update the indiv_standings table in the database"
  task :update_indiv_standings, [:use_db] => :environment do |t, args|
    db_selected = args[:use_db]
    puts "Database selected: #{db_selected}"
    include DatabaseSwitcher
    verify_database(db_selected)
    connect_to_db(db_selected)

    all_divisions = Division.active.all
    all_divisions.each do |division|
      puts "Individual standings for #{division.name}"
      year_quizzers = YearQuizzer.get_all_quizzers_for_division_for_year(division)
      position = 1
      puts "Starting to record indiv standings (#{year_quizzers.count} records)"
      year_quizzers.each do |yr_quizzer|
        standing = IndivStanding.find_or_create_by(student_id: yr_quizzer.quizzer.id)
        standing.position = position
        standing.student_id = yr_quizzer.quizzer.id
        standing.team_id = yr_quizzer.team.id
        standing.division_id = division.id
        standing.total_points = yr_quizzer.total_points
        standing.lowest_score = yr_quizzer.lowest_points
        standing.adjusted_points = yr_quizzer.adjusted_points
        standing.accuracy = yr_quizzer.total_accuracy

        # org = yr_quizzer.quizzer.current_organization
        # unless org.name == "N/A"
        #   standing.organization_id = org.id
        # end

        standing.organization_id = yr_quizzer.quizzer.current_organization.id

        if standing.save!
          puts "#{position}. #{yr_quizzer.quizzer.name} standing saved"
        else
          puts "Failed to save standing for #{yr_quizzer.quizzer.name}"
        end
        position += 1
      end
    end
  end
end

