class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :active_after, :datetime
    add_column :users, :password_reset_token, :string
    add_column :users, :password_reset_sent_at, :datetime
    add_column :users, :token_type, :string
  end
end
