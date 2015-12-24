class AddAdminNameToLeague < ActiveRecord::Migration
  def change
    add_column :leagues, :admin_name, :string
    add_column :leagues, :admin_email, :string
    remove_column :leagues, :admin, :string
  end
end
