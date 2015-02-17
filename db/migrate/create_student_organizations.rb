class CreateStudentOrganizations < ActiveRecord::Migration
  def change
    create_table :students_organizations do |t|
      t.references :student
      t.references :organization
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
