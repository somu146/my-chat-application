class MessagesController < ApplicationController
  before_action :load_entities

  def create
    @message =
      Message.create(
        user: current_user,
        conversation: @conversation,
        body: params.dig(:message, :body)
      )
    # RoomChannel.broadcast_to @room, @room_message
    head :ok
  end

  protected

  def load_entities
    @conversation = Conversation.find params.dig(:message, :conversation_id)
  end
end
