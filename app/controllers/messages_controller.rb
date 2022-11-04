class MessagesController < ApplicationController
  before_action :load_entities

  def create
    if @conversation.present?
      @message =
        Message.create(
          user: current_user,
          conversation: @conversation,
          body: params.dig(:message, :body)
        )
      RoomChannel.broadcast_to @conversation, @message
    elsif @group.present?
      @message =
        Message.create(
          user: current_user,
          group: @group,
          body: params.dig(:message, :body)
        )
      if @message.save
        GroupChannel.broadcast_to @group, @message
      end
    end
    head :ok
  end

  protected

  def load_entities
    if params.dig(:message, :conversation_id).present?
      @conversation = Conversation.find params.dig(:message, :conversation_id)
    elsif params.dig(:message, :group_id).present?
      @group = Group.find params.dig(:message, :group_id)
    end
  end
end
