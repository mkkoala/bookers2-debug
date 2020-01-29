class ChatChannel < ApplicationCable::Channel
 def subscribed
    stream_from "chat_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    chat = Chat.create!(message: data['message'],
                              user_id: current_user.id,
                              room_id: params['room_id'])
    render_chat = ApplicationController.renderer.render(partial: 'chats/chat',
                                                            locals: {chat: chat})
    ActionCable.server.broadcast 'chat_channel',
                                  message: render_chat,
                                  room_id: params['room_id']
  end
end
