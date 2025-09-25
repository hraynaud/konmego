module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      # Extract token from query parameters or headers
      token = request.params[:token] || request.headers['Authorization']&.split(' ')&.last

      return reject_unauthorized_connection unless token

      # Decode and verify the token (adjust this based on your auth system)
      decoded_token = Authentication.decode_token(token)
      user = Person.find(decoded_token['user_id'])

      return reject_unauthorized_connection unless user

      user
    rescue StandardError => e
      Rails.logger.error "ActionCable authentication error: #{e.message}"
      reject_unauthorized_connection
    end
  end
end
