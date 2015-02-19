class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.integer :grade
      t.boolean :captain
      t.boolean :active

      t.timestamps
    end
  end
end
