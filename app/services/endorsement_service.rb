require 'securerandom'

class EndorsementService
  ENDORSEMENT_LIMIT = 50

  class << self

    def has_available_endorsements?
      endorser.outgoing_endorsements.size > ENDORSEMENT_LIMIT
    end

    def create params
      create_from_nodes(Person.find(params[:endorser_id]), get_endorsee(params), get_topic(params))
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
      params[:endorsee_id].present?
    end

    def existing_topic? params
      params[:topic_id].present? and params[:new_topic].blank?
    end

    def new_person? params
      params[:endorsee_id].blank? and params[:new_person].present?
    end

    def new_topic? params
      params[:topic_id].blank? and params[:new_topic].present?
    end

    def endorsee_by_id params
      Person.find(params[:endorsee_id])
    end

    def topic_by_id params
      Topic.find(params[:topic_id])
    end

    def new_topic params
      TopicCreationService.create(params[:new_topic])
    end

    def new_identity email
      Identity.new({
        email: email,
        password: SecureRandom.base64(15)
      })
    end

    def new_endorsee params
      identity = new_identity(params.dig(:new_person, :identity,:email))
      if identity.valid?
        create_new_person params, identity
      end 
    end

    def create_new_person params, identity
      Person.new({
        first_name: params.dig(:new_person, :first),
        last_name: params.dig(:new_person, :last),
        identity:identity
      })
    end

  end

end
