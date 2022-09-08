require 'securerandom'

class EndorsementService
  ENDORSEMENT_LIMIT = 50

  class << self

    def has_available_endorsements? endorser
      endorser.outgoing_endorsements.size > ENDORSEMENT_LIMIT
    end

    def create endorser, params
      topic = find_or_create_topic params
      endorsee = Person.where(id: params[:endorsee_id]).first

      if endorsee 
        create_from_nodes(endorser, endorsee, topic)
      else
        invite = InviteService.create endorser, invite_params(params)
        invite
      end
    end

    def accept endorsement
      endorsement.tap do |e|
        RelationshipManager.create_friendship_if_none_exists_for(e)
        e.accepted!
        e.save
      end
    end

    def search_by_status user, status
      case status
      when "pending"
        EndorsementService.pending_endorsments(user)
      when "declined"
        EndorsementService.declined_endorsments(user)
      else 
        EndorsementService.accepted_endorsments(user)
      end
      
    end 

   def accepted_endorsments user
    endorsements_for user, "accepted"
   end 

   def pending_endorsments user
    endorsements_for user, "pending"
   end 

   def declined_endorsments user
    endorsements_for user, "declined"
   end 

    def endorsements_for user, status
      user.endorsements.send(status.to_sym)
    end 

    def decline endorsement
      return endorsement.tap do |e|
        endorsement.declined!
        endorsement.save
      end
    end

    private

    def invite_params params
      params.except(:new_topic_name, :new_topic_category, :endorsee_id)
    end  

    def find_or_create_topic params
      TopicService.get(topic_id: params[:topic_id], name: params[:new_topic_name], category: params[:new_topic_category])
    end

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
