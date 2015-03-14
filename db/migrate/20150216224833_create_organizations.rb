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
      t.decimal :latitude
      t.decimal :longitude
      t.boolean :active, default: true

      # t.timestamps
    end
  end
end
