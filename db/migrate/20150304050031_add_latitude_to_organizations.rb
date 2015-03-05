class AddLatitudeToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :latitude, :decimal
  end
end
