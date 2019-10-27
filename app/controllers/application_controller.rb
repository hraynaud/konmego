class ApplicationController < ActionController::API

  include ActionController::MimeResponds
  include ExceptionHandler
  before_action :authenticate_request, except:[:preflight]

  def preflight
    head :ok
  end

  private

  def rubify_keys hash
    hash.deep_transform_keys(&:underscore)
  end

  def current_user
    @current_user
  end

  def json_response(object, status)
    render json: object, status: status
  end

  def respond_with_token jwt
    json_response({jwt: jwt}, :ok)
  end

  def respond_with_error msg, status = :bad_request, errors={}
    response.set_header "X-Message", msg
    json_response(errors.to_json, status)
  end

  def respond_with_model_error model, status = :unprocessable_entity
    respond_with_error model.errors.full_messages.to_sentence, status, model.errors
  end

  def do_auth_failed
    respond_with_error "Authentication failed", 401
  end

  def authenticate_request
    begin
      uid = Authentication.uid_from_from_request_auth_hdr request.headers['Authorization']
      @current_user = Person.find(uid)
    rescue 
      do_auth_failed
    end
  end

end
