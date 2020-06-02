class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  before_action :current_user_id

  def execute
    pp 'variable'
    pp @variables
    pp 'type of variable'
    pp @variables.class
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: current_user,
    }
    result = BackendSchema.execute(query, variables: @variables, context: context, operation_name: operation_name)
    render json: result
  rescue => e
    raise e unless Rails.env.development?
    handle_error_in_development e
  end

  def login
    admin = Admin.find_by_email(@variables['email'])

    if admin && admin.authenticate(@variables['password'])        
      render json: {
        admin: {
          id: admin.id,
          email: admin.email,
          name: admin.name,
        },
        hhh: ActionToken.encode(admin.id, scope: 'login')
      }
    else
      { errors: [ServiceError.new(:emailOrPassword, 'invalid')]}
    end
  end

  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def bearer_token
    request.headers['Authorization']
  end

  def current_user_id
    
    @variables = ensure_hash(params[:variables])
    pp 'current_user'
    pp @variables
    return if @variables.has_key?('email') && @variables.has_key?('password')
    
    return if bearer_token && bearer_token.empty?

    claim = ActionToken.decode(bearer_token, scope: 'login')

    claim['sub']
  rescue JWT::InvalidAudError, JWT::InvalidIssuerError, JWT::DecodeError, JWT::ExpiredSignature
    render status: 401, json: { message: 'User not authorised' }
  end

  def current_user
    return unless current_user_id

    Admin.find_by_id(current_user_id)
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end
end
