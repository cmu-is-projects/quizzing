class CreateTeamCoaches < ActiveRecord::Migration
  def change
    create_table :team_coaches do |t|
      t.integer :team_id
      t.integer :coach_id
      t.date :start_date
      t.date :end_date

    end
  end
end
