class AuthenticationController < ApplicationController

  skip_before_action :authenticate_request

  def login
    resp = Authentication.login_by_password  params[:email], params[:password]
    if resp.jwt
      respond_with_token resp.jwt
    else
      do_auth_failed  resp.error
    end
  end

end
