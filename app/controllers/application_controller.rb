class ApplicationController < ActionController::API

  before_action :authenticate_request, only: [:current_user]

  def preflight
    head :ok
  end

  def current_user
    render json: @current_user, only: [:handle]
  end

  def index
    render file: '/public/index.html'
  end

  def pwd_login_success jwt
    render json: {jwt: jwt}, status: 200
  end

  def do_auth_failed error="Authentication failed"
    render json: {error: error}, status: 401
  end

  def authenticate_request
    begin
      uid = Authentication.uid_from_from_request_auth_hdr request.headers['Authorization']
      @current_user = User.find(uid)
    rescue 
      do_auth_failed
     end
  end

end
