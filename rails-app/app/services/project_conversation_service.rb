class ProjectConversationService < ConversationService
  class << self
    def recent_conversations(user)
      Conversation.active
                  .for_person(user.id)
                  .recent
                  .includes(:conversation_participants, :messages)
    end

    def create(project_id, user)
      project = ProjectService.find_with_associations(project_id)
      raise StandardError, 'Unauthorized' unless can_access?(project, user)

      Conversation.find_or_create_project_chat(project)
    rescue ActiveGraph::Node::Labels::RecordNotFound
      raise ActiveRecord::RecordNotFound, 'Project not found'
    end

    def can_access?(project, user)
      return true if project.owner == user
      # return true if project.participants.include?(user)

      return true if project.visibility == 'public'

      # For non-public projects, only contacts of project owner can access
      project.owner.contacts.include?(user)
    end

    def conversation_json(conversation)
      participants = conversation.participant_people.map do |person|
        next unless person

        # Find the participant record to get the role
        participant_record = conversation.participants.find { |p| p.person_id == person.id }

        {
          id: person.id,
          name: person.name,
          avatar_url: person.avatar_url,
          role: participant_record&.role || 'member'
        }
      end.compact

      {
        id: conversation.id,
        title: conversation.display_title,
        conversation_type: conversation.conversation_type,
        last_message_at: conversation.last_message_at,
        participants: participants,
        context: conversation_context_json(conversation),
        unread_count: conversation.unread_count_for(current_user.id),
        can_moderate: conversation.can_moderate?(current_user.id)
      }
    end

    def conversation_context_json(conversation)
      context = conversation.get_context_entity
      return nil unless context

      case conversation.context_type
      when 'Project'
        {
          type: 'project',
          id: context.id,
          name: context.name,
          description: context.description
        }
      when 'Topic'
        {
          type: 'topic',
          id: context.id,
          name: context.name
        }
      end
    end
  end
end
