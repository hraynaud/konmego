class ChatClient {
  constructor(token) {
    this.token = token;
    this.cable = null;
    this.channels = new Map();
  }

  connect() {
    this.cable = ActionCable.createConsumer(`ws://localhost:3000/cable?token=${this.token}`);
  }

  subscribeToConversation(conversationId, callbacks = {}) {
    if (this.channels.has(conversationId)) {
      return this.channels.get(conversationId);
    }

    const channel = this.cable.subscriptions.create(
      {
        channel: 'ChatChannel',
        conversation_id: conversationId
      },
      {
        connected: () => {
          console.log(`Connected to conversation ${conversationId}`);
          callbacks.onConnected?.();
        },

        disconnected: () => {
          console.log(`Disconnected from conversation ${conversationId}`);
          callbacks.onDisconnected?.();
        },

        received: (data) => {
          console.log('Received:', data);
          
          switch(data.type) {
            case 'new_message':
              callbacks.onNewMessage?.(data.message);
              break;
            case 'typing':
              callbacks.onTyping?.(data);
              break;
            case 'message_read':
              callbacks.onMessageRead?.(data);
              break;
            default:
              callbacks.onData?.(data);
          }
        }
      }
    );

    this.channels.set(conversationId, channel);
    return channel;
  }

  sendMessage(conversationId, content, messageType = 'text', replyToId = null) {
    const channel = this.channels.get(conversationId);
    if (channel) {
      channel.send({
        action: 'send_message',
        conversation_id: conversationId,
        content: content,
        message_type: messageType,
        reply_to_id: replyToId
      });
    }
  }

  sendTypingIndicator(conversationId, isTyping) {
    const channel = this.channels.get(conversationId);
    if (channel) {
      channel.send({
        action: 'typing',
        conversation_id: conversationId,
        is_typing: isTyping
      });
    }
  }

  markAsRead(conversationId, messageId) {
    const channel = this.channels.get(conversationId);
    if (channel) {
      channel.send({
        action: 'mark_as_read',
        conversation_id: conversationId,
        message_id: messageId
      });
    }
  }

  unsubscribeFromConversation(conversationId) {
    const channel = this.channels.get(conversationId);
    if (channel) {
      channel.unsubscribe();
      this.channels.delete(conversationId);
    }
  }

  disconnect() {
    this.channels.forEach(channel => channel.unsubscribe());
    this.channels.clear();
    if (this.cable) {
      this.cable.disconnect();
    }
  }
}

// Usage example:
// const chatClient = new ChatClient('your-jwt-token');
// chatClient.connect();
// 
// chatClient.subscribeToConversation(123, {
//   onNewMessage: (message) => console.log('New message:', message),
//   onTyping: (data) => console.log(`${data.user_name} is typing: ${data.is_typing}`),
//   onMessageRead: (data) => console.log(`Message ${data.message_id} read by user ${data.user_id}`)
// });
// 
// chatClient.sendMessage(123, 'Hello, world!');