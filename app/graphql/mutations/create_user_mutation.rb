module Mutations
  class CreateUserMutation < BaseMutation
    argument :name, String, required: true
    argument :phoneNumber, String, required: true
    argument :motNumber, String, required: true
    argument :areaOfOperation, String, required: true
    argument :address, String, required: true
    argument :hometown, String, required: true
    argument :state, String, required: true

    field :driver, Types::DriverType, null: true
    field :errors, [Types::ServiceErrorType], null: true

    def resolve(**inputs)
      result = CreateUser.perform(
        name: inputs[:name],
        phone_number: inputs[:phoneNumber],
        mot_number: inputs[:motNumber],
        area_of_operation: inputs[:areaOfOperation],
        address: inputs[:address],
        hometown: inputs[:hometown],
        state: inputs[:state],
      )

      if result.succeeded?
        {driver: result.value}
      else
        { errors: ServiceError.from(result.reason) } 
      end
    end
  end
end