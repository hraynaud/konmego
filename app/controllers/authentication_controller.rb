class AuthenticationController < ApplicationController

  def request_token
    request_token = TWITTER.get_request_token(oauth_callback: ENV['OAUTH_CALLBACK'])
    Oauth.create(token: request_token.token, secret: request_token.secret)
    redirect_to request_token.authorize_url(oauth_callback: ENV['OAUTH_CALLBACK'])
  end

  def access_token
    oauth = Oauth.find_by(token: params[:oauth_token])

    if oauth.present?
      jwt = Authentication.login_by_oauth_token oauth, params
      redirect_to ENV['ORIGIN'] + "?jwt=#{jwt}"
    else
      redirect_to ENV['ORIGIN']
    end
  end

  def login
    jwt = Authentication.login_by_password  params[:email], params[:password]

    if jwt
      pwd_login_success jwt
    else
      do_auth_failed "Incorrect email or password"
    end
  end

  private

  def pwd_login_success jwt
    render json: {jwt: jwt}, status: 200
  end

  def authenticate_request
    begin
      uid = JWT.decode(request.headers['Authorization'], Rails.application.secrets.secret_key_base)[0]['uid']
      @current_user = User.find_by(uid: uid)
    rescue JWT::DecodeError
      do_auth_failed
    end
  end

  def do_auth_failed error="Authentication failed"
    render json: {error: error}, status: 401
  end

end
