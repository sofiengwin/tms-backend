class AddResolvedAtToPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :resolved_at, :datetime
  end
end
