class AddPaidToLeague < ActiveRecord::Migration
  def change
    add_column :leagues, :paid, :boolean
  end
end
