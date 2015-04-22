class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.references :division
      t.references :organization
      t.string :name
      t.boolean :active, default: true

      # t.timestamps
    end
  end
end
