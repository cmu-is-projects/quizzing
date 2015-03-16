class CreateCoaches < ActiveRecord::Migration
  def change
    create_table :coaches do |t|
      t.references :user
      t.references :organization
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.boolean :active, default: true

      # t.timestamps
    end
  end
end
