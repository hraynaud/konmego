class ChatManagementService
  def initialize(current_user)
    @current_user = current_user
  end

  def create_direct_chat(other_user_neo4j_id)
    other_user = Person.find(other_user_neo4j_id)
    raise ActiveGraph::Node::Labels::RecordNotFound unless other_user

    Conversation.find_or_create_direct_message(@current_user.neo_id, other_user_neo4j_id)
  end

  def create_project_chat(project_neo4j_id)
    project = Project.find(project_neo4j_id)
    raise ActiveGraph::Node::Labels::RecordNotFound unless project

    unless can_access_project?(project)
      raise StandardError, "You must be a project owner or participant"
    end

    Conversation.find_or_create_project_chat(project)
  end

  def create_topic_chat(topic_neo4j_id)
    topic = Topic.find(topic_neo4j_id)
    raise ActiveGraph::Node::Labels::RecordNotFound unless topic

    Conversation.find_or_create_topic_chat(topic)
  end

  def create_group_chat(title, participant_neo4j_ids = [])
    # Verify all participants exist
    participants = participant_neo4j_ids.map { |id| Person.find(id) }

    Conversation.create_group_chat(title, @current_user.neo_id, participant_neo4j_ids)
  end

  def get_user_conversations
    Conversation.active
                .for_person(@current_user.neo_id)
                .recent
                .includes(:conversation_participants, :messages)
  end

  def search_conversations(query)
    conversations = get_user_conversations

    # Search in conversation titles and participant names
    conversations.joins(:conversation_participants)
                .where(
                  "conversations.title ILIKE ? OR EXISTS (
                    SELECT 1 FROM conversation_participants cp
                    WHERE cp.conversation_id = conversations.id
                    AND cp.person_neo4j_id IN (
                      SELECT neo_id FROM people WHERE name ILIKE ?
                    )
                  )",
                  "%#{query}%", "%#{query}%"
                )
                .distinct
  end

  def get_conversation_with_user(other_user_neo4j_id)
    Conversation.joins(:conversation_participants)
                .where(conversation_type: 'direct_message')
                .where(conversation_participants: { person_neo4j_id: [@current_user.neo_id, other_user_neo4j_id] })
                .group('conversations.id')
                .having('COUNT(conversation_participants.id) = 2')
                .first
  end

  def get_unread_messages_count
    conversations = get_user_conversations
    conversations.sum { |conv| conv.unread_count_for(@current_user.neo_id) }
  end

  def mark_conversation_as_read(conversation_id)
    conversation = Conversation.find(conversation_id)
    return false unless conversation.can_participate?(@current_user.neo_id)

    conversation.messages.unread_by(@current_user.neo_id).find_each do |message|
      message.mark_as_read!(@current_user.neo_id)
    end

    true
  end

  private

  def can_access_project?(project)
    project.owner == @current_user || project.participants.include?(@current_user)
  end
end
```
