class AddFailedChallengesToQuizTeams < ActiveRecord::Migration
  def change
    add_column :quiz_teams, :failed_challenges, :integer, default: 0
  end
end
