require "ostruct"

class Authentication
USER_ID_KEY_PARAM = "uid"
  def self.login_by_password email, pwd
    identity = Identity.find_by email: email

    if identity && identity.authenticate(pwd)
      OpenStruct.new({jwt: jwt_for(identity)})
    else 
      OpenStruct.new({jwt: nil, error: "Incorrect email or password"})
    end
  end

  def self.uid_from_from_request_auth_hdr auth_hdr
    begin
      header =  JWT.decode(auth_hdr, Rails.application.credentials.secret_key_base)
      header[0][USER_ID_KEY_PARAM]
    rescue JWT::DecodeError
      raise  "Invalid Authorization Token Credentials"
    end
  end


  def self.jwt_for identity
    JWT.encode({uid: identity.id, exp: 1.day.from_now.to_i}, Rails.application.credentials.secret_key_base)
  end


  def self.login_by_oauth_token oauth, request_params
    request_token = OAuth::RequestToken.new(TWITTER, oauth.token, oauth.secret)
    access_token = request_token.get_access_token(oauth_verifier: request_params[:oauth_verifier])
    identity = Identity.find_or_create_by(uid: access_token.params[:identity_id]) do |u|
      u.handle = access_token.params[:screen_name] 
      #sets random password to avoid validation errors since email and password
      #auth is also supported
      u.password = u.password_confirmation = SecureRandom.urlsafe_base64(n=6) 
    end
    jwt_for identity
  end
end
