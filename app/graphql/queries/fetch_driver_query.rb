module Queries
  class FetchDriverQuery < BaseResolver
    argument :driverId, ID,
      required: true,
      prepare: ->(id, _) { Driver.find_by_id(id) },
      as: :driver
    
    type Types::DriverType, null: true

    def resolve(driver:)
      raise GraphQL::ExecutionError.new("Something went wrong", extensions: { "driver" => "notFound" }) unless driver

      raise GraphQL::ExecutionError.new("Something went wrong", extensions: { "admin" => "notAuthorized" }) unless context[:current_user]

      driver
    end
  end
end