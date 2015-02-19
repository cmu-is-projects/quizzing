class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.references :division
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end
end
