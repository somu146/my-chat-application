class ConversationsController < ApplicationController
  before_action :load_conversation, only: %i[show edit update]
  before_action :load_conversations, only: %i[show index]

  def index
    @users = User.all.where.not(id: current_user)
  end

  def create
    if check_conversation?
      redirect_to conversation_path(@conversation.id)
    else
      @conversation = Conversation.create(recipient_id: params[:user_id], sender_id: current_user.id)
      if @conversation.save
        redirect_to conversation_path(@conversation.id)
      else
        redirect_to root_path
      end
    end
  end

  def show
    @users = User.all.where.not(id: current_user)
    @message = Message.new conversation: @conversation
    @messages = @conversation.messages.includes(:user)
  end

  protected

    def load_conversation
      @conversation = Conversation.find(params[:id]) if params[:id]
    end

    def load_conversations
      @conversations = Conversation.where(recipient_id: current_user.id).or(Conversation.where(sender_id: current_user.id))
    end

    def check_conversation?
      @conversation = Conversation.find_by(recipient_id: params[:user_id]) if params[:user_id]
      if @conversation
        true
      else
        false
      end
    end
end