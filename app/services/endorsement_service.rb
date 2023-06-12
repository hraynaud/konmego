require 'securerandom'

class EndorsementService
  ENDORSEMENT_LIMIT = 50

  class << self
    def has_available_endorsements?(endorser)
      endorser.outgoing_endorsements.size > ENDORSEMENT_LIMIT
    end

    def create(endorser, params)
      endorsee = Person.where(id: params[:endorsee_id]).first
      topic = TopicService.get(params[:topic_id])

      if topic
        topic_name = topic.name
      else
        topic_name = params[:new_topic_name]
        raise raise StandardError, 'Please provide a topic' if topic_name.nil?
      end

      if endorsee
        if already_exists? endorser, endorsee, topic_name
          raise raise StandardError, "You've alread endorsed #{@p2.name} for #{topic_name}"
        end

        create_from_nodes(endorser, endorsee, topic_name)
      else
        InviteService.create endorser, params

      end
    end

    def destroy(e)
      e.destroy
    end

    def find(id)
      Endorsement.find_by(id: id)
    end

    def accept(invite)
      endorsement = create_from_invite invite
      endorsement.accepted!
      endorsement.save
      RelationshipManager.create_friendship_if_none_exists_for(endorsement)

    end

    def search_by_status(user, status)
      case status
      when Endorsement.statuses[:pending]
        user.endorsements.pending
      when Endorsement.statuses[:declined]
        user.endorsements.declined
      when Endorsement.statuses[:accepted]
        user.endorsements.accepted
      else
        user.endorsements.accepted_or_pending
      end
    end

    def decline(endorsement)
      endorsement.declined!
      endorsement.save
      endorsement
    end

    private

    def create_from_invite(invite)
      topic = invite.topic || TopicService.find_or_create_by_name(invite.topic_name)
      to = invite.receiver || PersonService.find_or_create_from_invite(invite)
      create_from_nodes(invite.sender, to, topic.name)
    end

    def already_exists?(endorser, endorsee, topic)
      endorser.endorsees.each_rel.select { |r| r.to_node == endorsee && r.topic == topic }.count > 0
    end

    def invite_params(params)
      params.except(:new_topic_name, :new_topic_category, :endorsee_id)
    end

    def create_from_nodes(endorser, endorsee, topic_name)
      c = Endorse.new(from_node: endorser, to_node: endorsee)
      c.topic = topic_name
      c.save
      c
    end
  end
end
