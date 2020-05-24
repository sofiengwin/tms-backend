module Mutations
  class LoginMutation < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :admin, Types::AdminType, null: true
    field :hhh, String, null: true
    field :errors, [Types::ServiceErrorType], null: true

    def resolve(email:, password:)
      admin = Admin.find_by_email(email)

      if admin && admin.authenticate(password)        
        {admin: admin, hhh: ActionToken.encode(admin.id, scope: 'login')}
      else
        { errors: [ServiceError.new(:emailOrPassword, 'invalid')]}
      end
    end
  end
end