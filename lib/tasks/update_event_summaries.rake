namespace :db do
  desc "Update the event_summaries table in the database"
  task :update_event_summaries, [:use_db] => :environment do |t, args|
    db_selected = args[:use_db]
    puts "Database selected: #{db_selected}"
    include DatabaseSwitcher
    verify_database(db_selected)
    connect_to_db(db_selected)

    past_events = Event.past.chronological.all 
    all_divisions = Division.active.all

    past_events.each do |event|
      all_divisions.each do |division|
        puts "Calculating summary for event on #{event.start_date}; #{division.name} division"
        students = EventQuizzer.get_all_quizzers_for_event_and_division(event, division)
        teams    = EventTeam.get_all_teams_for_event_and_division(event, division)
        student_points = students.map{|eq| eq.total_points}.sort
        team_points    = teams.map{|eq| eq.total_points}.sort

        summary = EventSummary.where(event_id: event.id, division_id: division.id).first_or_initialize
        summary.avg_student_points = student_points.sum / student_points.size
        summary.avg_team_points    = team_points.sum / team_points.size
        summary.max_student_points = student_points.pop
        summary.max_team_points    = team_points.pop
        summary.max_student_id     = nil
        summary.max_team_id        = nil
        summary.save!
      end
    end

  end
end