class CreateStudentQuizzes < ActiveRecord::Migration
  def change
    create_table :student_quizzes do |t|
      t.integer :student_id
      t.integer :quiz_id
      t.integer :num_correct
      t.integer :num_attempts
      t.integer :num_fouls
      t.integer :score

    end
  end
end
