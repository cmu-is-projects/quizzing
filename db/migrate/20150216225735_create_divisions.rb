class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.string :name
      t.integer :start_grade
      t.integer :end_grade
      t.boolean :active, default: true

    end
  end
end
