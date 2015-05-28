class CreateTeamStandings < ActiveRecord::Migration
  def change
    create_table :team_standings do |t|
      t.integer :position
      t.integer :team_id
      t.string :division_id
      t.integer :total_points
      t.float :accuracy

      t.timestamps
    end
  end
end
