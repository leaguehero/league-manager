class AddPriceToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :price, :int
  end
end
