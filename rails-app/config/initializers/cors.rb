# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    allowed_origins = case Rails.env
                      when 'development'
                        ['http://localhost:9000', 'https://konmego-client.fly.dev']
                      when 'production'
                        ['https://konmego.com', 'https://www.konmego.com']
                      else # For staging or other environments
                        ['https://konmego-client.fly.dev']
                      end

    origins allowed_origins
    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             expose: ['Authorization,jwt', 'X-Message']
  end
end
