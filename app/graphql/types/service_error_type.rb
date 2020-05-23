module Types
  class ServiceErrorType < Types::BaseObject
    field :field, String, null: false
    field :code, String, null: false
  end
end