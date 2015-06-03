class AddSeatToStudentTeams < ActiveRecord::Migration
  def change
    add_column :student_teams, :seat, :integer
  end
end
