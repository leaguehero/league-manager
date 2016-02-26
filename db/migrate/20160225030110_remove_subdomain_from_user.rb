class RemoveSubdomainFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :subdomain, :string
  end
end
