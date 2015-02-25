class RemoveCaptainFromStudents < ActiveRecord::Migration
  def up
    remove_column :students, :captain
  end

  def down
    add_column :students, :captain, :boolean, default: false
  end
end
