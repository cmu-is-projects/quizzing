class CreateTeamQuizzes < ActiveRecord::Migration
  def change
    create_table :teams_quizzes do |t|
      t.references :team
      t.references :quiz
      t.integer :score_raw
      t.integer :score_calc
      t.integer :num_timeouts
      t.integer :num_challenges_lost

      t.timestamps
    end
  end
end
