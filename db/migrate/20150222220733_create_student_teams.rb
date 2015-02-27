class CreateStudentTeams < ActiveRecord::Migration
  def change
    create_table :student_teams do |t|
      t.integer :student_id
      t.integer :team_id
      t.boolean :is_captain, default: false
      t.boolean :active, default: true
      t.date :start_date
      t.date :end_date

    end
  end
end
