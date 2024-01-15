require 'securerandom'

class PersonService
  class << self
    def get(person_id, first_name, last_name, email, password); end

    def create_by_endorserment(params)
      create params.merge({ password: SecureRandom.hex(12) })
    end

    def create(params)
      Person.new.tap do |p|
        p.first_name = params[:first_name]
        p.last_name = params[:last_name]
        p.email = params[:email]
        p.password = params[:password]
        p.save
      end
    end

    def find_or_create_from_invite(invite)
      person = Identity.where(email: invite.email).first.try(:person)

      person || Person.new.tap do |p|
        p.first_name = invite.first_name
        p.last_name = invite.last_name
        p.email = invite.email
        p.save
      end
    end

    def find_by_id(id)
      Person.where(id: id).first
    end
  end
end
