class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.integer :num_rounds
      t.integer :organization_id

      # t.timestamps
    end
  end
end
