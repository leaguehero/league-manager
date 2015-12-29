class CreatePreLeagues < ActiveRecord::Migration
  def change
    create_table :pre_leagues do |t|
      t.string :league_name
      t.string :subdomain
      t.integer :max_teams
      t.integer :max_players_per_team
      t.string :admin_name
      t.string :admin_email

      t.timestamps null: false

    end
  end
end
