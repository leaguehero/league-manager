class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :team_one
      t.integer :team_two
      t.integer :winner
      t.integer :loser
      t.string :location
      t.integer :winner_score
      t.integer :loser_score
      t.datetime :time

      t.timestamps null: false
    end
  end
end
