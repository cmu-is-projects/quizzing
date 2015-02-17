class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.date :roster_lock_date
      t.boolean :drop_lowest_score
      t.boolean :roster_lock_toggle
      t.boolean :auto_promote_students

      t.timestamps
    end
  end
end
