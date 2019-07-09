require 'securerandom'

class EndorsementService
  class << self
    def create_for_existing_person_node endorser, endorsee, topic
      return create_endorsement endorser, endorsee, topic
    end

    def create_for_new_person_node endorser, new_node, topic
      endorsee = Person.create({
        email: new_node[:email], 
        first_name: new_node[:first_name],
        last_name: new_node[:last_name],
        password: SecureRandom.base64(15)
      })

      return create_endorsement endorser, endorsee, topic
    end

    def create_endorsement endorser, endorsee, topic
      return Endorsement.new.tap do |endorsement|
        endorsement.endorser = endorser
        endorsement.endorsee = endorsee
        endorsement.topic = topic
        endorsement.save
      end
    end

  end
end
