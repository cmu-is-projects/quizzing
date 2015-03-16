class AddActiveToDivisions < ActiveRecord::Migration
  def change
    add_column :divisions, :active, :boolean
  end
end
