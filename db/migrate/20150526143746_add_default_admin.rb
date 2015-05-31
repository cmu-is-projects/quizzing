class AddDefaultAdmin < ActiveRecord::Migration
  def change
    u = User.new
    u.username = 'chesstiger91'
    u.password = 'question1question...'
    u.password_confirmation = 'question1question...'
    u.role = 'admin'
    u.active = true
    u.active_after = Time.now
    u.save!
  end
end
