class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.references :division
      t.string :name
      t.boolean :active, default: true
      t.integer :organization_id

      # t.timestamps
    end
  end
end
