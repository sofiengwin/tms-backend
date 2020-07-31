module Types
  class PaymentType < BaseObject
    field :driver, DriverType, null: false
    field :cashier, AdminType, null: false
    field :amount, Int, null: false
    field :createdAt, String, null: false
    field :paymentType, String, null: false

    def created_at
      object.created_at.strftime('%Y-%-m-%-dT%H:%M')
    end
  end
end