class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.references :division
      t.references :event
      t.string :room_num
      t.integer :round_num
      t.boolean :active, default: true

      # t.timestamps
    end
  end
end
