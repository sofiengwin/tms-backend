class AddAreaOfOperationToAdmins < ActiveRecord::Migration[6.0]
  def change
    add_column :admins, :area_of_operation, :string
  end
end
