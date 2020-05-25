module Queries
  class ListDriversQuery < BaseResolver
    type [Types::DriverType], null: false

    def resolve
      raise GraphQL::ExecutionError.new("Something went wrong", extensions: { "admin" => "notAuthorized" }) unless context[:current_user]

      Driver.all
    end
  end
end