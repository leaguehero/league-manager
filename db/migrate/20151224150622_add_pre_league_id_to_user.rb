class AddPreLeagueIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :pre_league_id, :integer
  end
end
