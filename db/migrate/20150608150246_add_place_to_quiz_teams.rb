class AddPlaceToQuizTeams < ActiveRecord::Migration
  def change
    add_column :quiz_teams, :place, :integer
  end
end
