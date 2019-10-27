module TestUtils
  def extract_errors
    response.headers["X-Message"]
  end
end



def do_put user, path, payload
  put path, params: payload, headers:{'Authorization': Authentication.jwt_for(user)}
end

def do_post user, path, payload
  post path, params: payload, headers:{'Authorization': Authentication.jwt_for(user)}
end

#method to map random simple to actually enums on model returns nil if key not in enum_options 
def match_enum_key_from_options enum_options, key
  enum_options.key(enum_options[key])
end
