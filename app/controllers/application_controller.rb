class ApplicationController < ActionController::API

  include ActionController::MimeResponds

  before_action :authenticate_request, except:[:preflight, :index]

  def preflight
    head :ok
  end

  def index
    head :ok
    #respond_to do |format|
      #format.html { render body: Rails.root.join('public/index.html').read }
    #end
  end

  private

  def current_user
    @current_user
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
      @current_user = Person.find(uid)
    rescue 
      do_auth_failed
    end
  end

end
