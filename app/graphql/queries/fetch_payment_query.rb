module Queries
  class FetchPaymentQuery < BaseResolver
    argument :paymentId, ID,
      required: true,
      prepare: ->(id, _) { Payment.find_by_id(id) },
      as: :payment
    
    type Types::PaymentType, null: true

    def resolve(payment:)
      raise GraphQL::ExecutionError.new("Something went wrong", extensions: { "payment" => "notFound" }) unless Payment

      raise GraphQL::ExecutionError.new("Something went wrong", extensions: { "admin" => "notAuthorized" }) unless context[:current_user]

      payment
    end
  end
end