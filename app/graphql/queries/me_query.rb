module Queries
  class MeQuery < BaseResolver
    type Types::AdminType, null: true

    def resolve
      context[:current_user] || GraphQL::ExecutionError.new("Something went wrong", extensions: { "admin" => "notAuthorized" })
    end
  end
end