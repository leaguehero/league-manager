class AddPaymentOptionToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :payment_option, :string
  end
end
