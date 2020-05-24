module Types
  class PaymentType < BaseObject
    field :driver, DriverType, null: false
    field :cashier, AdminType, null: false
    field :amount, Int, null: false
  end
end