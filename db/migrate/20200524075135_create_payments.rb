class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.references :cashier
      t.integer :amount
      t.references :driver

      t.timestamps
    end
  end
end
