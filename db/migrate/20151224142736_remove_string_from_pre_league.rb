class RemoveStringFromPreLeague < ActiveRecord::Migration
  def change
    remove_column :pre_leagues, :string
  end
end
