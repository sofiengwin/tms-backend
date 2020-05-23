module Types
  class DriverType < Types::BaseObject
    field :name, String, null: false
    field :phone_number, String, null: false
    field :mot_number, String, null: false
    field :address, String, null: false
    field :area_of_operation, String, null: false
    field :hometown, String, null: false
    field :state, String, null: false
  end
end