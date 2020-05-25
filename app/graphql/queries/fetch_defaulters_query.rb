module Queries
  class FetchDefaultersQuery < BaseResolver
    class DefaultersType < Types::BaseObject
      field :monday, [Types::DriverType], null: true, hash_key: 'Monday'
      field :tuesday, [Types::DriverType], null: true, hash_key: 'Tuesday'
      field :wednesday, [Types::DriverType], null: true, hash_key: 'Wednesday'
      field :thursday, [Types::DriverType], null: true, hash_key: 'THursday'
      field :friday, [Types::DriverType], null: true, hash_key: 'Friday'
    end

    type DefaultersType, null: false

    def resolve
      raise GraphQL::ExecutionError.new("Something went wrong", extensions: { "admin" => "notAuthorized" }) unless context[:current_user]

      FetchDefaulters.perform.value
    end 
  end
end