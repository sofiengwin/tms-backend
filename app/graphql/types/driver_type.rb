module Types
  class DriverType < Types::BaseObject
    field :name, String, null: false
    field :phoneNumber, String, null: false
    field :motNumber, String, null: false
    field :address, String, null: false
    field :areaOfOperation, String, null: false
    field :hometown, String, null: false
    field :state, String, null: false
    field :qrCode, String, null: true
    
    field :payments, [Types::PaymentType], null: true
  end
end