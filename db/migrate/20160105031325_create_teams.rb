class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :captain
      t.integer :asst_captain

      t.timestamps null: false
    end
  end
end
