class AddPrimaryContact < ActiveRecord::Migration
  def change
    add_column :organizations, :primary_contact_id, :integer
  end
end
