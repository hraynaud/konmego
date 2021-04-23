require 'securerandom'

class EndorsementService
  ENDORSEMENT_LIMIT = 50

  class << self

    def has_available_endorsements?
      endorser.outgoing_endorsements.size > ENDORSEMENT_LIMIT
    end

    def create endorser, params
      topic = TopicService.get(topic_id: params[:topic_id], name: params[:new_topic_name], category: params[:new_topic_category])

      endorsee = PersonService.get(params[:endorsee_id], params[:new_person_first_name], params[:new_person_last_name], params[:new_person_email], SecureRandom.alphanumeric(10))

      create_from_nodes(endorser, endorsee, topic)
    end

    def accept endorsement
      return endorsement.tap do |e|
        RelationshipManager.create_friendship_if_none_exists_for(e)
        e.accepted!
        e.save
      end
    end

    def decline endorsement
      return endorsement.tap do |e|
        endorsement.declined!
        endorsement.save
      end
    end

    private

    def create_from_nodes endorser, endorsee, topic
      return build_endorsement(endorser, endorsee, topic).tap do |endorsement|
        endorsement.save!
      end
    end

    def build_endorsement endorser, endorsee, topic
      return Endorsement.new.tap do |endorsement|
        endorsement.endorser = endorser
        endorsement.endorsee = endorsee
        endorsement.topic = topic
      end
    end

  end

end
