require 'base64'

class EndorsementService
  ENDORSEMENT_LIMIT = 50

  class << self
    def has_available_endorsements?(endorser)
      endorser.endorsees.size > ENDORSEMENT_LIMIT
    end

    def create(endorser, params)
      topic = find_or_create_topic(params)
      raise StandardError, 'Please provide a topic' if topic.nil?

      endorsee = find_or_create_endorsee(params)
      endorsement = create_from_nodes(endorser, endorsee, topic, params[:description])
      send_confirmation endorsement
      endorsement
    end

    def send_confirmation(endorsement)
      if endorsement.endorsee.status == 'non_member'
        EndorsementMailer.with(id: endorsement.id).non_member_email.deliver_later
      else
        EndorsementMailer.with(id: endorsement.id).member_email.deliver_later
      end
    end

    def accept(endorsement, user)
      raise StandardError, 'Invalid Operation' if endorsement.endorsee != user

      endorsement.accept
      optimized = optimize_for_embedding(endorsement)
      endorsement.embeddings = OllamaService.embedding(optimized)
      endorsement.save
      RelationshipManager.create_friendship_if_none_exists_for(endorsement)
      endorsement
    end

    def decline(endorsement, user)
      raise StandardError, 'Invalid Operation' if endorsement.endorsee != user

      endorsement.decline!
      endorsement
    end

    def destroy(endorsement, user)
      raise StandardError, 'Invalid Operation' unless can_destroy? endorsement, user

      endorsement.destroy
    end

    def find(id)
      Endorsement.find_by(id:)
    end

    def generate_id(endorser_id, endorsee_id, topic)
      from_id = Obfuscation::IdCodec.encode(endorser_id)
      to_id = Obfuscation::IdCodec.encode(endorsee_id)
      encoded = "#{from_id}:#{to_id}:#{topic}"
      Obfuscation::IdCodec.urlsafe_encode64(encoded)
    end

    def decompose_id(encoded_id)
      unbase64 = Obfuscation::IdCodec.urlsafe_decode64(encoded_id)
      from, to, topic = unbase64.split(':')
      [Obfuscation::IdCodec.decode(from), Obfuscation::IdCodec.decode(to), topic]
    end

    def optimize_for_embedding(endorsement)
      "#{endorsement.topic.like_terms}\n#{endorsement.description}"
    end

    private

    def can_destroy?(endorsement, user)
      status_accepted_and_user_is_either_party?(endorsement,
                                                user) || status_pending_or_declined_and_user_is_endorser?(endorsement,
                                                                                                          user)
    end

    def status_accepted_and_user_is_either_party?(endorsement, user)
      endorsement.status == Endorse.accepted && (endorsement.to_node == user || endorsement.from_node == user)
    end

    def status_pending_or_declined_and_user_is_endorser?(endorsement, user)
      (endorsement.status == Endorse.pending || endorsement.status == Endorse.declined) && endorsement.from_node == user
    end

    def find_or_create_endorsee(params)
      endorsee = Person.where(id: params[:endorsee_id]).first
      return endorsee if endorsee

      unless params[:email] && params[:first_name] && params[:last_name]
        raise StandardError, "Can't create and invite endorsee; email, first_name, last_name are required."
      end

      endorsee = PersonService.create_by_endorserment(params)

      endorsee.status = 'non_member'

      endorsee
    end

    # def validate_non_duplicated_endorsement(endorser, endorsee, topic_name)
    #   return unless already_exists?(endorser, endorsee, topic_name)

    #   raise raise StandardError, "You've already endorsed #{endorsee.name} for #{topic_name}"
    # end

    def find_or_create_topic(params)
      if params[:topic_id]
        TopicService.get(params[:topic_id])
      elsif params[:new_topic_name]
        TopicService.find_or_create_by_name({ name: params[:new_topic_name], category: params[:new_category_name] })
      end
    end

    def create_from_invite(invite)
      topic = invite.topic || TopicService.find_or_create_by_name(invite.topic_name)
      to = invite.receiver || PersonService.find_or_create_from_invite(invite)
      create_from_nodes(invite.sender, to, topic.name, "this person is amazing at #{topic.name}")
    end

    def invite_params(params)
      params.except(:new_topic_name, :new_topic_category, :endorsee_id)
    end

    def create_from_nodes(endorser, endorsee, topic, description)
      raise StandardError, 'Endorsement Exists' if not_unique(endorser, endorsee, topic)

      as_node(endorser, endorsee, topic, description)
    end

    def as_node(endorser, endorsee, topic, description)
      Endorsement.new.tap do |endorsement|
        endorsement.endorser = endorser
        endorsement.endorsee = endorsee
        endorsement.description = description
        endorsement.topic = topic
        endorsement.status = Endorsement.statuses[:pending]
        endorsement.save
      end
    end

    def not_unique(endorser, endorsee, topic)
      Endorsement.where(endorser:, endorsee:,
                        topic:).any?
    end
  end
end
