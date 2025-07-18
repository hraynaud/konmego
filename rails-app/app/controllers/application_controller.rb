class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::MimeResponds
  include ExceptionHandler
  before_action :authenticate_request, except: [:preflight]
  before_action :json_to_snake_case_keys

  def preflight
    head :ok
  end

  protected

  def json_response(object, status)
    render json: object, status:
  end

  def for_user
    params[:user_id] ? PersonService.find_by(id: params[:user_id]) : current_user
  end

  private

  def json_to_snake_case_keys
    rubify_keys params
  end

  def rubify_keys(hash)
    hash.deep_transform_keys!(&:underscore)
  end

  attr_reader :current_user

  def respond_with_token(jwt)
    response.set_header 'jwt', jwt
    json_response({}, :ok)
  end

  def respond_with_error(msg, status = :bad_request, errors = {})
    response.set_header 'X-Message', msg
    json_response(errors.to_json, status)
  end

  def respond_with_model_error(model, status = :unprocessable_entity)
    respond_with_error model.errors.full_messages.to_sentence, status, model.errors
  end

  def do_auth_failed(err_msg = 'Incorrect email or password')
    respond_with_error err_msg, 401
  end

  def authenticate_request
    logger.debug "attempting to authenticate request with auth header: #{request.headers['Authorization']}"
    auth = request.headers['Authorization'] || request.params['authorization']
    uid = Authentication.uid_from_from_request_auth_hdr auth

    @current_user = Person.find(uid)
  rescue StandardError => e
    do_auth_failed e.message
  end
end
