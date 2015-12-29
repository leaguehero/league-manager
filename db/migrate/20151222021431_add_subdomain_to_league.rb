class AddSubdomainToLeague < ActiveRecord::Migration
  def change
    add_column :leagues, :subdomain, :string
  end
end
