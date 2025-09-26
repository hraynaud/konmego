class ChatChannel < ApplicationCable::Channel
  def subscribed
    conversation = Conversation.find(params[:conversation_id])

    if conversation && conversation.can_participate?(current_user.id)
      stream_for conversation
      Rails.logger.info "User #{current_user.id} subscribed to conversation #{conversation.id}"
    else
      reject
    end
  end

  def unsubscribed
    Rails.logger.info "User #{current_user&.id} unsubscribed from chat"
  end

  def send_message(data)
    conversation = Conversation.find(data['conversation_id'])
    return unless conversation&.can_participate?(current_user.id)

    message = conversation.messages.create!(
      content: data['content'],
      sender_id: current_user.id,
      message_type: data['message_type'] || 'text',
      reply_to_id: data['reply_to_id']
    )

    # Broadcasting is handled by the Message model's after_create callback
  rescue StandardError => e
    Rails.logger.error "Error sending message: #{e.message}"
    transmit({ error: e.message })
  end

  def typing(data)
    conversation = Conversation.find(data['conversation_id'])
    return unless conversation&.can_participate?(current_user.id)

    ChatChannel.broadcast_to(conversation, {
                               type: 'typing',
                               user_id: current_user.id,
                               user_name: current_user.name,
                               is_typing: data['is_typing']
                             })
  rescue StandardError => e
    Rails.logger.error "Error in typing indicator: #{e.message}"
  end

  def mark_as_read(data)
    conversation = Conversation.find(data['conversation_id'])
    return unless conversation&.can_participate?(current_user.id)

    message = Message.find(data['message_id'])
    message.mark_as_read!(current_user.id)

    ChatChannel.broadcast_to(conversation, {
                               type: 'message_read',
                               message_id: message.id,
                               user_id: current_user.id
                             })
  rescue StandardError => e
    Rails.logger.error "Error marking message as read: #{e.message}"
  end

  private

  def current_user
    connection.current_user
  end
end
