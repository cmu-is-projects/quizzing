class CreateQuizTeams < ActiveRecord::Migration
  def change
    create_table :quiz_teams do |t|
      t.integer :quiz_id
      t.integer :team_id
      t.integer :position
      t.integer :raw_score
      t.integer :points

    end
  end
end
