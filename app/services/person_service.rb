require 'securerandom'

class PersonService

  class << self

    def get person_id, first_name, last_name, email, password

    end

    def find_or_create_from_invite invite
      person = Identity.where(email: invite.email).first.try(:person)
      
      person || Person.new.tap do| p|
          p.first_name = invite.first_name
          p.last_name = invite.last_name
          p.email = invite.email
          p.save
      end

    end

    def create registration
      Person.create({
        identity: registration.identity
      })

    end
  end

end
