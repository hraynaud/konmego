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

      # Use your existing authentication method
      user_id = Authentication.uid_from_from_request_auth_hdr("Bearer #{token}")
      user = Person.find(user_id)

      return reject_unauthorized_connection unless user

      Rails.logger.info "ActionCable: User #{user.name} (#{user.id}) authenticated successfully"
      user
    rescue StandardError => e
      Rails.logger.error "ActionCable authentication error: #{e.message}"
      reject_unauthorized_connection
    end
  end
end
