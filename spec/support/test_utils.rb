module TestUtils
  def extract_errors
    response.headers["X-Message"]
  end
end
