require "ostruct"

class Authentication
  USER_ID_KEY_PARAM = "uid"

  def self.login_by_password email, pwd
    identity = Identity.find_by email: email

    if identity && identity.authenticate(pwd)
      login_success identity
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

  def self.login_success identity
    OpenStruct.new({jwt: jwt_for(identity)})
  end

  def self.jwt_for identity 
    p = identity.person
    JWT.encode({uid: identity.id, email: identity.email, name: p.name, exp: 1.day.from_now.to_i}, Rails.application.credentials.secret_key_base)
  end

end
