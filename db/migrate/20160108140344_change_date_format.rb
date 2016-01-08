class ChangeDateFormat < ActiveRecord::Migration
  def change
    remove_column :games, :time, :datetime
    add_column :games, :time, :string
    add_column :games, :date, :string
  end
end
