require 'ostruct'

class Authentication
  USER_ID_KEY_PARAM = 'uid'

  def self.login_by_password(email, pwd)
    p = Person.find_by email: email
    if p && p.authenticate(pwd)
      login_success p
    else
      OpenStruct.new({ jwt: nil, error: 'Incorrect email or password' })
    end
  end

  def self.login_success(person)
    Rails.logger.debug('login was successful')

    OpenStruct.new({ jwt: jwt_for(person) })
  end

  def self.uid_from_from_request_auth_hdr(auth_hdr)
    auth_hdr.gsub!('Bearer ', '')
    begin
      header = JWT.decode(auth_hdr, Rails.application.secret_key_base, true, { algorithm: 'HS256' })
      header[0][USER_ID_KEY_PARAM]
    rescue JWT::DecodeError
      raise 'Invalid Authorization Token Credentials'
    end
  end

  def self.generate_validation_code
    6.times.map { rand(10) }.join
  end

  def self.jwt_for(p)
    JWT.encode({ uid: p.id, email: p.email, name: p.name, avatar: p.avatar_url, exp: 1.day.from_now.to_i },
               Rails.application.secret_key_base, 'HS256')
  end
end
