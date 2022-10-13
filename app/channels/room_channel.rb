class RoomChannel < ApplicationCable::Channel
  def subscribed
    conversation = Conversation.find_by id: params[:conversation]
    stream_for conversation
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
