class AddCoachToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :coach, :string
    add_column :teams, :points_for, :integer
    add_column :teams, :points_against, :integer
  end
end
