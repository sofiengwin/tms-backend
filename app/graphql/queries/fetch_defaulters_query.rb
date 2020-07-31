module Queries
  class FetchDefaultersQuery < BaseResolver
    class DefaulterType < Types::BaseObject
      field :defaultedAt, String, null: true
      field :driver, Types::DriverType, null: true

      def driver
        object
      end
      
      def defaulted_at
        Time.now.strftime('%Y-%-m-%-dT%H:%M')
      end
    end
    class DefaultersType < Types::BaseObject
      field :monday, [DefaulterType], null: true, hash_key: 'Monday'
      field :tuesday, [DefaulterType], null: true, hash_key: 'Tuesday'
      field :wednesday, [DefaulterType], null: true, hash_key: 'Wednesday'
      field :thursday, [DefaulterType], null: true, hash_key: 'Thursday'
      field :friday, [DefaulterType], null: true, hash_key: 'Friday'
    end

    type DefaultersType, null: false

    def resolve
      raise GraphQL::ExecutionError.new("Something went wrong", extensions: { "admin" => "notAuthorized" }) unless context[:current_user]

      FetchDefaulters.perform.value
    end 
  end
end