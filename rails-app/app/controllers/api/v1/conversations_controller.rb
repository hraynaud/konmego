module Api
  module V1
    class ConversationsController < ApplicationController
      before_action :find_conversation_by_context, only: %i[show_direct show_project show_topic]
      before_action :find_conversation, only: %i[show_group update destroy add_participant remove_participant]

      def index
        conversations = Conversation.active
                                    .for_person(current_user.id)
                                    .recent
                                    .includes(:conversation_participants, :messages)

        render json: {
          conversations: conversations.map { |conv| conversation_json(conv) }
        }
      end

      # Direct message endpoints
      def show_direct
        render_conversation_with_messages
      end

      def create_direct
        other_user_id = params[:other_user_id]
        conversation = Conversation.find_or_create_direct_message(current_user.id, other_user_id)
        render json: { conversation: conversation_json(conversation) }
      rescue StandardError => e
        render json: { error: e.message }, status: :unprocessable_entity
      end

      # Project conversation endpoints
      def show_project
        render_conversation_with_messages
      end

      def create_project
        project = Project.find(params[:project_id])
        unless can_access_project_chat?(project, current_user)
          return render json: { error: 'Unauthorized' }, status: :forbidden
        end

        conversation = Conversation.find_or_create_project_chat(project)
        render json: { conversation: conversation_json(conversation) }
      rescue ActiveGraph::Node::Labels::RecordNotFound
        render json: { error: 'Project not found' }, status: :not_found
      end

      def mark_project_as_read
        project = Project.find(params[:project_id])
        conversation = Conversation.find_by(
          conversation_type: 'project_chat',
          context_type: 'Project',
          context_id: project.id
        )

        return render json: { error: 'Conversation not found' }, status: :not_found unless conversation

        unless conversation.can_participate?(current_user)
          return render json: { error: 'Unauthorized' },
                        status: :forbidden
        end

        mark_conversation_as_read(conversation)
      end

      # Topic conversation endpoints
      def show_topic
        render_conversation_with_messages
      end

      def create_topic
        topic = Topic.find(params[:topic_id])
        conversation = Conversation.find_or_create_topic_chat(topic)

        # Auto-add the creator as a participant for topic chats
        unless conversation.conversation_participants.exists?(person_id: current_user.id)
          conversation.conversation_participants.create!(
            person_id: current_user.id,
            role: 'member'
          )
        end

        render json: { conversation: conversation_json(conversation) }
      rescue ActiveGraph::Node::Labels::RecordNotFound
        render json: { error: 'Topic not found' }, status: :not_found
      end

      def mark_topic_as_read
        topic = Topic.find(params[:topic_id])
        conversation = Conversation.find_by(
          conversation_type: 'topic_chat',
          context_type: 'Topic',
          context_id: topic.id
        )

        return render json: { error: 'Conversation not found' }, status: :not_found unless conversation

        unless conversation.can_participate?(current_user)
          return render json: { error: 'Unauthorized' },
                        status: :forbidden
        end

        mark_conversation_as_read(conversation)
      end

      # Group conversation endpoints (keep existing ID-based approach)
      def create_group
        title = conversation_params[:title] || 'Group Chat'
        participant_ids = conversation_params[:participant_ids] || []

        conversation = Conversation.create_group_chat(title, current_user.id, participant_ids)
        render json: { conversation: conversation_json(conversation) }
      rescue StandardError => e
        render json: { error: e.message }, status: :unprocessable_entity
      end

      def show_group
        unless @conversation.can_participate?(current_user)
          return render json: { error: 'Unauthorized' },
                        status: :forbidden
        end

        render_conversation_with_messages
      end

      private

      def find_conversation_by_context
        case action_name
        when 'show_direct'
          other_user_id = params[:other_user_id]
          @conversation = Conversation.joins(:conversation_participants)
                                      .where(conversation_type: 'direct_message')
                                      .group(:id)
                                      .having('COUNT(conversation_participants.id) = 2')
                                      .where(conversation_participants: {
                                               person_id: [current_user.id, other_user_id],
                                               left_at: nil
                                             })
                                      .first
        when 'show_project'
          project = Project.where(uuid: params[:project_id])
          @context = project.with_associations(:owner, :participants).first
          @conversation = Conversation.find_by(
            conversation_type: 'project_chat',
            context_type: 'Project',
            context_id: @context.id
          )
        when 'show_topic'
          topic = Topic.find(params[:topic_id])
          @conversation = Conversation.find_by(
            conversation_type: 'topic_chat',
            context_type: 'Topic',
            context_id: topic.id
          )
        end

        return render json: { error: 'Conversation not found' }, status: :not_found unless @conversation

        unless @conversation.can_participate?(@current_user, @context)
          render json: { error: 'Unauthorized' },
                 status: :forbidden
        end
      rescue ActiveGraph::Node::Labels::RecordNotFound
        render json: { error: 'Context not found' }, status: :not_found
      end

      def render_conversation_with_messages
        page = (params[:page] || 1).to_i
        per_page = (params[:per_page] || 50).to_i
        offset = (page - 1) * per_page

        # Load messages (1 PostgreSQL query)
        messages = @conversation.messages
                                .undeleted
                                .chronological
                                .offset(offset)
                                .limit(per_page)

        # Get all unique sender IDs (no additional queries)
        sender_ids = messages.pluck(:sender_id).compact.uniq

        # Load all people at once (1 Neo4j query)
        people_cache = @conversation.load_participants_batch(sender_ids)

        # Build messages JSON manually using cache
        messages_json = messages.map do |msg|
          sender = people_cache[msg.sender_id]
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
            can_edit: msg.can_edit?(current_user.id),
            can_delete: msg.can_delete?(current_user.id),
            is_read: msg.read_by?(current_user.id)
          }
        end
        render json: {
          id: @conversation.id,
          context_id: @conversation.context_id,
          context_type: @conversation.context_type,
          messages: messages_json,
          pagination: {
            page: page,
            per_page: per_page,
            total_messages: @conversation.messages.undeleted.count
          }
        }
      end

      def mark_conversation_as_read(conversation)
        conversation.messages.unread_by(current_user.id).find_each do |message|
          message.mark_as_read!(current_user.id)
        end

        render json: { message: 'Messages marked as read' }
      end

      def find_conversation
        @conversation = Conversation.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Conversation not found' }, status: :not_found
      end

      def conversation_params
        params.require(:conversation).permit(:conversation_type, :title, :other_user_id, :project_id, :topic_id,
                                             participant_ids: [])
      end

      def create_direct_message
        other_user_id = conversation_params[:other_user_id]

        begin
          conversation = Conversation.find_or_create_direct_message(current_user.id, other_user_id)
          render json: { conversation: conversation_json(conversation) }
        rescue StandardError => e
          render json: { error: e.message }, status: :unprocessable_entity
        end
      end

      def create_project_conversation
        project = Project.find(conversation_params[:project_id])

        # Check if user can access this project chat
        unless can_access_project_chat?(project, current_user)
          return render json: { error: 'Unauthorized' }, status: :forbidden
        end

        conversation = Conversation.find_or_create_project_chat(project)
        render json: { conversation: conversation_json(conversation) }
      rescue ActiveGraph::Node::Labels::RecordNotFound
        render json: { error: 'Project not found' }, status: :not_found
      end

      def create_topic_conversation
        topic = Topic.find(conversation_params[:topic_id])
        conversation = Conversation.find_or_create_topic_chat(topic)

        # Auto-add the creator as a participant for topic chats
        unless conversation.conversation_participants.exists?(person_id: current_user.id)
          conversation.conversation_participants.create!(
            person_id: current_user.id,
            role: 'member'
          )
        end

        render json: { conversation: conversation_json(conversation) }
      rescue ActiveGraph::Node::Labels::RecordNotFound
        render json: { error: 'Topic not found' }, status: :not_found
      end

      def create_group_conversation
        title = conversation_params[:title] || 'Group Chat'
        participant_ids = conversation_params[:participant_ids] || []

        conversation = Conversation.create_group_chat(title, current_user.id, participant_ids)
        render json: { conversation: conversation_json(conversation) }
      rescue StandardError => e
        render json: { error: e.message }, status: :unprocessable_entity
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

      private

      def can_access_project_chat?(project, user)
        # Project owner and participants can always access
        return true if project.owner == user
        return true if project.participants.include?(user)

        # For public projects, anyone can access
        return true if project.visibility == 'public'

        # For non-public projects, only contacts of project owner can access
        project.owner.contacts.include?(user)
      end
    end
  end
end
