require 'securerandom'

class PersonService

  class << self

    def get person_id, first_name, last_name, email, password

    end


    def create registration
      Person.create({
        identity: registration.identity
      })

    end
  end

end
