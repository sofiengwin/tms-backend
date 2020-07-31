class AddTypeToPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :type, :string
  end
end
