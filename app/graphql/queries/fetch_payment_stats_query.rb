module Queries
  class FetchPaymentStatsQuery < BaseResolver
    argument :cashierId, ID,
      required: false,
      prepare: ->(id, _) { Admin.find_by_id(id) },
      as: :cashier
    
    type Types::PaymentStatsType, null: true

    def resolve(cashier:)
      raise GraphQL::ExecutionError.new("Something went wrong", extensions: { "admin" => "notAuthorized" }) unless context[:current_user]

      result = PaymentStats.perform(cashier: cashier)

      result.value.merge(cashier: cashier)
    end
  end
end