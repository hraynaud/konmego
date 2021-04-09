require 'securerandom'

class PersonService

  class << self

    def get person_id, first_name, last_name, email
      person = begin 
                 Person.find(person_id) 
               rescue 
                 create(first_name, last_name, email)
               end
    end

    private 

    def create first_name, last_name, email
      identity = new_identity(email)

      if identity.valid?
        create_new_person first_name, last_name, identity
      end

    end

    def new_identity email
      Identity.new({
        email: email,
        password: SecureRandom.base64(15)
      })
    end

    def create_new_person first_name, last_name, identity
      Person.create({
        first_name: first_name,
        last_name: last_name,
        identity: identity
      })
    end

  end


end
