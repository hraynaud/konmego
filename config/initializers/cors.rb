# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # origins 'localhost:8080' #Add production domain here
    origins { |source, _env| Rails.env.development? && source == 'http://localhost:9000' }
    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head], expose: ['Authorization,jwt', 'X-Message']
  end
end
