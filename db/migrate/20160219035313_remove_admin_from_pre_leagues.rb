class RemoveAdminFromPreLeagues < ActiveRecord::Migration
  def change
    remove_column :pre_leagues, :admin_name, :string
    remove_column :pre_leagues, :admin_email, :string
  end
end
