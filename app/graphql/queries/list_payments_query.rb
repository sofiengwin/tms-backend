module Queries
  class ListPaymentsQuery < BaseResolver
    type [Types::PaymentType], null: false

    def resolve
      raise GraphQL::ExecutionError.new("Something went wrong", extensions: { "admin" => "notAuthorized" }) unless context[:current_user]

      Payment.all
    end
  end
end