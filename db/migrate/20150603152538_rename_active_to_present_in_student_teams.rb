class RenameActiveToPresentInStudentTeams < ActiveRecord::Migration
  def change
    rename_column :student_teams, :active, :present
  end
end
