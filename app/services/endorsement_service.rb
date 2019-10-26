require 'securerandom'

class EndorsementService
  ENDORSEMENT_LIMIT = 50

  class << self

    def has_available_endorsements?
      endorser.outgoing_endorsements.size > ENDORSEMENT_LIMIT
    end

    def create params
      create_from_nodes(Person.find(params[:endorserId]), get_endorsee(params), get_topic(params))
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

    def create_from_nodes endorser, endorsee, topic
      return build_endorsement(endorser, endorsee, topic).tap do |endorsement|
        endorsement.save
      end
    end

    def build_endorsement endorser, endorsee, topic
      return Endorsement.new.tap do |endorsement|
        endorsement.endorser = endorser
        endorsement.endorsee = endorsee
        endorsement.topic = topic
      end
    end

    def get_endorsee params
      if existing_person? params
        endorsee_by_id params
      else
        new_endorsee params
      end
    end

    def get_topic params
      if existing_topic? params
        topic_by_id params
      else
        new_topic params
      end
    end

    def existing_person? params
      params[:endorseeId].present?
    end

    def existing_topic? params
      params[:topicId].present? and params[:newTopic].blank?
    end

    def new_person? params
      params[:endorseeId].blank? and params[:newPerson].present?
    end

    def new_topic? params
      params[:topicId].blank? and params[:newTopic].present?
    end

    def endorsee_by_id params
      Person.find(params[:endorseeId])
    end

    def topic_by_id params
      Topic.find(params[:topicId])
    end

    def new_topic params
      TopicCreationService.create(params[:newTopic])
    end

    def new_endorsee params
      Person.new({
        email: params[:newPerson][:email], 
        first_name: params[:newPerson][:first],
        last_name: params[:newPerson][:last],
        password: SecureRandom.base64(15)
      })
    end 

  end
end
