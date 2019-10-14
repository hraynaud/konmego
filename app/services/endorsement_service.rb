require 'securerandom'

class EndorsementService
  class << self
    def create_for_existing_person_node endorser, endorsee, topic
      return create_endorsement endorser, endorsee, topic
    end

    def create_for_new_person_node endorser, new_node, topic
      endorsee = new_endorsee(new_node)

      create_endorsement(endorser, endorsee, topic)
    end

    def build_endorsement endorser, endorsee, topic
      return Endorsement.new.tap do |endorsement|
        endorsement.endorser = endorser
        endorsement.endorsee = endorsee
        endorsement.topic = topic
      end
    end

    def create_endorsement endorser, endorsee, topic
      return build_endorsement(endorser, endorsee, topic).tap do |endorsement|
        endorsement.save
      end
    end

    def accept endorsement
      RelationshipManager.create_friendship_if_none_exists_for(endorsement)
      endorsement.accepted!
      endorsement.save
    end

    def decline endorsement
      endorsement.declined!
      endorsement.save
    end

    private

    def new_endorsee new_node
      Person.new({
        email: new_node[:email], 
        first_name: new_node[:first_name],
        last_name: new_node[:last_name],
        password: SecureRandom.base64(15)
      })
    end 

  end
end
