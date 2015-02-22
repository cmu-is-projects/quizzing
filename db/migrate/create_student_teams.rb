class CreateStudentTeams < ActiveRecord::Migration
  def change
    create_table :students_teams do |t|
      t.references :student
      t.references :team
      t.date :start_date
      t.date :end_date
      
      t.timestamps
    end
  end
end
