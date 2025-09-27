class ConversationService
  class << self
    def create_conversation(user1, user2)
      Conversation.create(user1: user1, user2: user2)
    end

    def recent_conversations(user)
      Conversation.active
                  .for_person(user.id)
                  .recent
                  .includes(:conversation_participants, :messages)
    end

    def load_conversation(conversation_id)
      Conversation.find(conversation_id)
    end

    def messages_with_user_permissions(conversation, current_user_id, params)
      messages = load_messages(conversation, params)
      sender_ids = messages.pluck(:sender_id).compact.uniq
      people_cache = conversation.load_participants_batch(sender_ids)

      messages.map do |msg|
        sender = people_cache[msg.sender_id]
        as_json(msg, sender, current_user_id)
      end
    end

    def find_by_context(params, current_user)
      conversation = case params[:action]
                     when 'show_direct'
                       direct_message(params, current_user)
                     when 'show_project'
                       project(params, current_user)
                     when 'show_topic'
                       topic(params)
                     end

      raise StandardError, 'Conversation not found' unless conversation

      conversation
    end

    def project(params, current_user)
      context = ProjectService.with_associations(params[:project_id])

      conversation = Conversation.find_by(
        conversation_type: 'project_chat',
        context_type: 'Project',
        context_id: context.id
      )
      raise StandardError, 'Unauthorized' unless conversation.can_participate?(current_user, context)

      conversation
    end

    def topic(params)
      topic = Topic.find(params[:topic_id])
      Conversation.find_by(
        conversation_type: 'topic_chat',
        context_type: 'Topic',
        context_id: topic.id
      )
    end

    def direct_message(params, current_user)
      other_user_id = params[:other_user_id]
      Conversation.joins(:conversation_participants)
                  .where(conversation_type: 'direct_message')
                  .group(:id)
                  .having('COUNT(conversation_participants.id) = 2')
                  .where(conversation_participants: {
                           person_id: [current_user.id, other_user_id],
                           left_at: nil
                         })
                  .first
    end

    def as_json(msg, sender, current_user_id)
      {
        id: msg.id,
        content: msg.display_content,
        sender_id: msg.sender_id,
        sender_name: sender&.name,
        sender_avatar: sender&.avatar_url,
        message_type: msg.message_type,
        reply_to_id: msg.reply_to_id,
        created_at: msg.created_at,
        updated_at: msg.updated_at,
        edited_at: msg.edited_at,
        can_edit: msg.can_edit?(current_user_id),
        can_delete: msg.can_delete?(current_user_id),
        is_read: msg.read_by?(current_user_id)
      }
    end

    def load_messages(conversation, params)
      page = (params[:page] || 1).to_i
      per_page = (params[:per_page] || 50).to_i
      offset = (page - 1) * per_page

      conversation.messages
                  .undeleted
                  .chronological
                  .offset(offset)
                  .limit(per_page)
    end
  end
end
