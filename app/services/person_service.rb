require 'securerandom'

class PersonService

  class << self

    def get person_id, first_name, last_name, email, password
      Person.where(id: person_id).first or 
        create(first_name, last_name, email, password)
    end

    def create first_name, last_name, email, password
      identity = new_identity(email, password, first_name, last_name)
      if identity.valid?
        create_new_person first_name, last_name, identity
      end

    end

    private 

    def new_identity email, password, first_name, last_name
      Identity.new({
        email: email,
        password: password,
        first_name: first_name,
        last_name: last_name,
      })
    end

    def create_new_person first_name, last_name, identity
      Person.create({
        identity: identity
      })
    end

  end


end
