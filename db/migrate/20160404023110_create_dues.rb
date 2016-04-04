class CreateDues < ActiveRecord::Migration
  def change
    create_table :dues do |t|
      t.integer :player_id
      t.boolean :paid
      t.integer :league_id
    end
  end
end
