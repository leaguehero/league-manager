class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name
      t.string :url
      t.integer :max_teams
      t.integer :max_players_per_team
      t.string :admin

      t.timestamps null: false
    end
  end
end
