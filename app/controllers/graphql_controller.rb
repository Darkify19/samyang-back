class GraphqlController < ApplicationController

  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    
    context = {
      session: session,  # Rails session is now accessible
      current_user: current_user,
    }
    
    result = TestBackendSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?
    handle_error_in_development(e)
  end
  
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def prepare_variables(variables_param)
    case variables_param
    when String
      JSON.parse(variables_param) || {}
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash
    else
      {}
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")
    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end
end
