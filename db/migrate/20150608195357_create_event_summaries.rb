class CreateEventSummaries < ActiveRecord::Migration
  def change
    create_table :event_summaries do |t|
      t.integer :event_id
      t.integer :division_id
      t.float :avg_student_points
      t.float :avg_team_points
      t.integer :max_student_points
      t.integer :max_team_points
      t.integer :max_student_id
      t.integer :max_team_id

      t.timestamps
    end
  end
end
