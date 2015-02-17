class CreateStudentQuizzes < ActiveRecord::Migration
  def change
    create_table :students_quizzes do |t|
      t.references :student
      t.references :quiz
      t.integer :num_correct
      t.integer :num_answered
      t.integer :num_fouls

      t.timestamps
    end
  end
end
