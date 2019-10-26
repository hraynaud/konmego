class ApplicationController < ActionController::API

  include ActionController::MimeResponds

  before_action :authenticate_request, except:[:preflight]

  def preflight
    head :ok
  end

  private

  def current_user
    @current_user
  end

  def respond_with_token jwt
    render json: {jwt: jwt}, status: 200
  end

  def respond_with_error errors, status = 422
    head status, {"X-Message" => errors.full_messages.to_json}
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
