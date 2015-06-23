class PopulateSettings < ActiveRecord::Migration
  def up
  	Setting.create(roster_lock_date: 2.days.from_now, drop_lowest_score: true, roster_lock_toggle: false, auto_promote_students: false, area_name: 'Test Area', admin_name: 'Test Area', admin_email: 'asdf@abc123.com', intro: 'Please update your info')
  end

  def down
  	Setting.first.delete
  end

end
