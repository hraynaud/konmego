require 'net/http'
require 'uri'
require 'json'
require 'pry'

module OpenAiAssistant
  openai_api_key = ENV['OPENAI_API_KEY']
  OPEN_API_THREADS_BASE_URL = 'https://api.openai.com/v1/threads'.freeze

  HEADERS = {
    'Content-Type' => 'application/json',
    'Authorization' => "Bearer #{openai_api_key}",
    'OpenAI-Beta' => 'assistants=v1'
  }.freeze

  class Generator
    def initialize(prefix)
      @prompt_prefix = prefix
      @thread_id = nil
      @run_id = nil
    end

    def generate(prompt)
      create_thread if @thread_id.nil?
      add_message(prompt)
      create_run
      status = run_status
      return 'timed out' if status != 'completed'

      data = messages
      JSON.parse(data[0]['content'][0]['text']['value'])
    end

    private

    def create_thread
      thread = send_request(Net::HTTP::Post)
      @thread_id = thread['id']
    end

    def add_message(prompt)
      content = "#{@prompt_prefix} #{prompt}"
      message_body = {
        'role' => 'user',
        'content' => content
      }
      send_request(Net::HTTP::Post, "/#{@thread_id}/messages", message_body)
    end

    def create_run
      path = "/#{@thread_id}/runs"
      message_body = {
        "assistant_id": @assistant_id
      }
      run = send_request(Net::HTTP::Post, path, message_body)
      @run_id = run['id']
    end

    def run_status
      path = "/#{@thread_id}/runs/#{@run_id}"
      response = send_request(Net::HTTP::Get, path)

      start_time = Time.now

      while Time.now - start_time < 60
        response = send_request(Net::HTTP::Get, path)
        break if response['status'] == 'completed'

        sleep(1)

      end
      response['status']
    end

    def messages
      path = "/#{@thread_id}/messages"
      response = send_request(Net::HTTP::Get, path)
      response['data']
    end

    def send_request(http_method, path = nil, body = nil)
      uri = URI("#{OPEN_API_THREADS_BASE_URL}#{path}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = http_method.new(uri, HEADERS)
      request.body = body.to_json if body

      response = http.request(request)
      JSON.parse(response.body)
    end
  end

  class ProjectGenerator < Generator
    def initialize
      @assistant_id = 'asst_qsOee1BHdjmjdT5r8fkxO3LG'
      super 'Please generate a project pertaining to '
    end
  end

  class EndorsementGenerator < Generator
    def initialize
      @assistant_id = 'asst_lwv2AnN4tVc9oEDCKc8E6Yo9'
      super 'Please endorse'
    end
  end
end
