class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :short_name
      t.string :street_1
      t.string :street_2
      t.string :city
      t.string :state
      t.string :zip
      t.decimal :latitutde
      t.decimal :longitude
      t.boolean :active

      t.timestamps
    end
  end
end
