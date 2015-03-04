class RemoveLatitutdeFromOrganizations < ActiveRecord::Migration
  def change
    remove_column :organizations, :latitutde, :decimal
  end
end
