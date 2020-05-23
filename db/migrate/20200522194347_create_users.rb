class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :type
      t.string :name
      t.string :phone_number
      t.string :mot_number
      t.string :address
      t.string :area_of_operation
      t.string :hometown
      t.string :state

      t.timestamps
    end
  end
end
