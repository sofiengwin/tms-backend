module Mutations
  class RecordPaymentMutation < BaseMutation
    argument :cashierId, ID,
      required: true,
      prepare: ->(id, _) { Admin.find_by_id(id) },
      as: :cashier
    
    argument :driverId, ID,
      required: true,
      prepare: ->(id, _) { Driver.find_by_id(id) },
      as: :driver

    argument :amount, Int, required: false
    argument :paymentType, String, required: false
    argument :resolvedAt, String, required: false

    field :payment, Types::PaymentType, null: true
    field :errors, [Types::ServiceErrorType], null: true

    def resolve(cashier:, driver:, amount:, paymentType: 'Cash', resolvedAt: Time.now)
      return { errors: [ServiceError.new(:admin, 'notAuthorized')] } unless context[:current_user]

      unless cashier || driver
        return { errors: [ServiceError.new(:driverOrCashier, 'blank')]}
      end

      result = RecordPayment.perform(
        cashier: cashier,
        driver: driver,
        amount: amount,
        payment_type: paymentType,
        resolved_at: resolvedAt
      )

      if result.succeeded?
        { payment: result.value }
      else
        { errors: ServiceError.from(result.reason) }
      end
    end
  end
end