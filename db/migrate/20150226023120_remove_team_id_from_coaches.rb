class RemoveTeamIdFromCoaches < ActiveRecord::Migration
  def change
    remove_column :coaches, :team_id, :integer
  end
end
