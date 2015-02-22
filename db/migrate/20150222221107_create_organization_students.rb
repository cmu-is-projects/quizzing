class CreateOrganizationStudents < ActiveRecord::Migration
  def change
    create_table :organization_students do |t|
      t.integer :organization_id
      t.integer :student_id
      t.date :start_date
      t.date :end_date

    end
  end
end
