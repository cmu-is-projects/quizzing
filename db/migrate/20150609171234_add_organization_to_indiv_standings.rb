class AddOrganizationToIndivStandings < ActiveRecord::Migration
  def change
    add_column :indiv_standings, :organization_id, :integer
  end
end
