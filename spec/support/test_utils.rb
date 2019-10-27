module TestUtils
  def extract_errors
    response.headers["X-Message"]
  end

  def parse_body response
    JSON.parse(response.body)
  end

  def do_put user, path, payload={}
    put path, params: payload, headers:{'Authorization': Authentication.jwt_for(user)}
  end

  def do_post user, path, payload={}
    post path, params: payload, headers:{'Authorization': Authentication.jwt_for(user)}
  end


  #method to map random simple to actually enums on model returns nil if key not in enum_options 
  def match_enum_key_from_options enum_options, key
    enum_options.key(enum_options[key])
  end

  module RSpec

    def expect_response_and_model_json_to_match response, model
      expect(parse_body(response)).to eq (JSON.parse(model.to_json))
    end

    def expect_http response, status
      expect(response).to have_http_status(status)
    end

  end
end
