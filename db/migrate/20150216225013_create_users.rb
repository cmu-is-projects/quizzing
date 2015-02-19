class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :role
      t.string :password_hash
      t.string :password_salt
      t.boolean :active

      t.timestamps
    end
  end
end
