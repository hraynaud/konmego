module Api
  module V1
    class MessagesController < ApplicationController
      before_action :find_conversation
      before_action :find_message, only: %i[show update destroy mark_as_read]

      def index
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
          messages: messages.map { |msg| msg.as_json(current_user_id: current_user.id) },
          pagination: {
            page: page,
            per_page: per_page,
            total_messages: @conversation.messages.undeleted.count
          }
        }
      end

      def create
        unless @conversation.can_participate?(current_user.id)
          return render json: { error: 'Unauthorized' },
                        status: :forbidden
        end

        # Additional check for project chats based on visibility
        if @conversation.project_chat?
          project = @conversation.context_entity
          if project && !can_message_in_project_chat?(project, current_user)
            return render json: { error: 'You cannot message in this project chat' }, status: :forbidden
          end
        end

        message = @conversation.messages.build(message_params.merge(sender_id: current_user.id))

        if message.save
          render json: { message: message.as_json(current_user_id: current_user.id) }, status: :created
        else
          render json: { errors: message.errors }, status: :unprocessable_entity
        end
      end

      def update
        return render json: { error: 'Unauthorized' }, status: :forbidden unless @message.can_edit?(current_user.id)

        if @message.edit_content!(message_params[:content], current_user.id)
          render json: { message: @message.as_json(current_user_id: current_user.id) }
        else
          render json: { errors: @message.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        return render json: { error: 'Unauthorized' }, status: :forbidden unless @message.can_delete?(current_user.id)

        @message.soft_delete!
        render json: { message: 'Message deleted' }
      end

      def mark_as_read
        unless @conversation.can_participate?(current_user.id)
          return render json: { error: 'Unauthorized' },
                        status: :forbidden
        end

        @message.mark_as_read!(current_user.id)
        render json: { message: 'Message marked as read' }
      end

      private

      def find_conversation
        @conversation = Conversation.find(params[:conversation_id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Conversation not found' }, status: :not_found
      end

      def find_message
        @message = @conversation.messages.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Message not found' }, status: :not_found
      end

      def message_params
        params.require(:message).permit(:content, :message_type, :reply_to_id)
      end

      def can_message_in_project_chat?(project, user)
        # Project owner and participants can always message
        return true if project.owner == user
        return true if project.participants.include?(user)

        # For public projects, anyone can message
        return true if project.visibility == 'public'

        # For non-public projects, only contacts of project owner can message
        project.owner.contacts.include?(user)
      end
    end
  end
end
