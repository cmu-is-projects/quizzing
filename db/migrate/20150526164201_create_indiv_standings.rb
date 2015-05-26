class CreateIndivStandings < ActiveRecord::Migration
  def change
    create_table :indiv_standings do |t|
      t.integer :position
      t.integer :student_id
      t.integer :current_team
      t.string :total_points_integer
      t.integer :lowest_score
      t.integer :adjusted_points
      t.float :accuracy

      t.timestamps
    end
  end
end
