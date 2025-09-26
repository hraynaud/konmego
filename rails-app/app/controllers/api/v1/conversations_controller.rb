module Api
  module V1
    class ConversationsController < ApplicationController
      before_action :find_conversation,
                    only: %i[show update destroy mark_as_read add_participant remove_participant]

      def index
        conversations = Conversation.active
                                    .for_person(current_user.id)
                                    .recent
                                    .includes(:conversation_participants, :messages)

        render json: {
          conversations: conversations.map { |conv| conversation_json(conv) }
        }
      end

      def show
        unless @conversation.can_participate?(current_user.id)
          return render json: { error: 'Unauthorized' },
                        status: :forbidden
        end

        page = (params[:page] || 1).to_i
        per_page = (params[:per_page] || 50).to_i
        offset = (page - 1) * per_page

        messages = @conversation.messages
                                .undeleted
                                .chronological
                                .offset(offset)
                                .limit(per_page)

        render json: {
          conversation: conversation_json(@conversation),
          messages: messages.map { |msg| msg.as_json(current_user_id: current_user.id) },
          pagination: {
            page: page,
            per_page: per_page,
            total_messages: @conversation.messages.undeleted.count
          }
        }
      end

      def create
        case conversation_params[:conversation_type]
        when 'direct_message'
          create_direct_message
        when 'project_chat'
          create_project_conversation
        when 'topic_chat'
          create_topic_conversation
        when 'group_chat'
          create_group_conversation
        else
          render json: { error: 'Invalid conversation type' }, status: :bad_request
        end
      end

      def update
        unless @conversation.can_moderate?(current_user.id)
          return render json: { error: 'Unauthorized' },
                        status: :forbidden
        end

        if @conversation.update(title: conversation_params[:title])
          render json: { conversation: conversation_json(@conversation) }
        else
          render json: { errors: @conversation.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        unless @conversation.can_moderate?(current_user.id)
          return render json: { error: 'Unauthorized' },
                        status: :forbidden
        end

        @conversation.archive!
        render json: { message: 'Conversation archived' }
      end

      def mark_as_read
        unless @conversation.can_participate?(current_user.id)
          return render json: { error: 'Unauthorized' },
                        status: :forbidden
        end

        @conversation.messages.unread_by(current_user.id).find_each do |message|
          message.mark_as_read!(current_user.id)
        end

        render json: { message: 'Messages marked as read' }
      end

      def add_participant
        unless @conversation.can_moderate?(current_user.id)
          return render json: { error: 'Unauthorized' },
                        status: :forbidden
        end
        unless @conversation.group_chat?
          return render json: { error: 'Invalid conversation type' },
                        status: :bad_request
        end

        participant_id = params[:person_id]

        if @conversation.add_participant!(participant_id)
          render json: { message: 'Participant added successfully' }
        else
          render json: { error: 'Failed to add participant' }, status: :unprocessable_entity
        end
      end

      def remove_participant
        unless @conversation.can_moderate?(current_user.id)
          return render json: { error: 'Unauthorized' },
                        status: :forbidden
        end
        unless @conversation.group_chat?
          return render json: { error: 'Invalid conversation type' },
                        status: :bad_request
        end

        participant_id = params[:person_id]
        @conversation.remove_participant!(participant_id)

        render json: { message: 'Participant removed successfully' }
      end

      private

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
        context = conversation.context_entity
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
